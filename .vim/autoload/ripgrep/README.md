# ripgrep


## TOC

<!-- mtoc start {{{ -->

* [Overview](#overview)
* [Usage](#usage)
* [設計](#%E8%A8%AD%E8%A8%88)

<!-- }}} mtoc end -->


## Overview

`ripgrep`を使って非同期に検索をするためのインターフェース。  
２つのモジュールで構成される。  
- job.vim
- parser.vim


## Usage

基本は、下記４インターフェースでジョブを起動する。  
- `ripgrep#job#start`
- `ripgrep#job#wait`
- `ripgrep#job#stop`
- `ripgrep#job#call`

ジョブの結果はパーサーオブジェクトによってオブジェクトにパースされる。  
- `ripgrep#parser#parser()`
- `s:Parser.parse(line)`



```txt
                        async                               +----------+
                                               +----------> | async    |
                                               |            +----------+
                                               |                     |
=====================================================================|=====================
    user                ripgrep                |                     |
                                               | jobの作成           | 通知
                                               |                     |   - stdout
    +--------+                            +---------+                |   - stderr
    | User   | -------------------------> | job     |                |   - exit
    |        | * start                    |         |                |
    |        |   * cmd & option           |         |                |
    |        |   * cwd                    |         |                |
    |        |   * callback               |         |                |
    |        |     * stdout               |         |                |
    |        |     * stderr               |         |                |
    |        |     * exit                 |         |                |
    |        |     * reset                |         |                |
    |        |                            |         |                |
    |        | <------------------------- |         | <--------------+
    |        |  * jobid                   |         |
    |        |  * notification            |         |
    |        |                            +---------+
    |        |
    |        |
    |        |                            +--------------+
    |        | -------------------------> | parser       |
    |        |  * create                  |              | 今のParserの実装だとデータが欠損していた。
    |        |                            |              | Quickfix用途だけであればいいんだけどそうじゃないならうまくない。
    |        | <------------------------- |              | だから、データを欠損させる処理を削って受け取ったデータをそのままJson => Object変換をする。
    |        |  * parser object           |              | そうなると、Json Objectが必ず返却されるわけではなく、Nullが変えることがあることが注意
    |        |                            |              |
    |        | -------------------------> |              |
    |        |  * parse (stdout)          |              |
    |        |                            |              |
    |        | <------------------------- |              |
    |        |  * json object / null      |              |
    |        |                            |              |
    |        |                            +--------------+
    |        |
    +--------+
```

## 設計

### 目標
- ripgrep プロセスをジョブ API で非同期実行し、Vim 8.2 以降と Neovim で共通のインターフェースを維持する。
- parser モジュールは ripgrep --json からの行を欠損なく取り込み、呼出側に構造化データを返却する。
- 設定値は `get(g:, 'ripgrep_*', default)` で参照し、ユーザーがグローバル変数で挙動を上書きできるようにする。

### コンポーネント構成
- `job.vim`: ripgrep 実行コマンド、引数構築、ジョブ開始・停止・待機 API をまとめる。内部ロジックは script-local 関数で実装し、autoload 関数は薄いラッパーにする。
- `parser.vim`: ripgrep の JSON 行を辞書へデコードし、呼出側が使いやすい形へ整形する。状態を持つ Parser オブジェクトは script-local で定義し、`ripgrep#parser#new()` などのファクトリー関数で公開する。

### データフロー
1. 呼出側が `ripgrep#job#start()` で検索を開始。`get(g:, 'ripgrep_command', 'rg')` などの設定値を取り込み、実行コマンドを決定する。
2. ジョブが stdout/stderr/exit の各コールバックを通じて通知を行い、利用側にハンドラを渡せるようにする。
3. stdout の各行は parser の `parse()` へ渡され、match/file_begin/file_end/finish などのイベント辞書に変換される。
4. 呼出側はイベントタイプに応じて quickfix 更新やプレビュー描画などを実行する。

### 設定項目の例
- `g:ripgrep_command`: 使用する実行ファイル (既定: `'rg'` または `'rg.exe'`)。
- `g:ripgrep_base_options`: 追加の ripgrep 引数をリストで指定 (既定: `['--json', '--no-line-buffered', '--no-block-buffered']`)。
- `g:ripgrep_overlapped`: `vim#async#job#start()` の `overlapped` を切り替えるブール値 (既定: `v:true`)。

### リファクタリング方針
1. 既存の `ripgrep#job#*` や `ripgrep#parser#*` 内部ロジックを `s:` 関数へ切り出し、外部公開 API は最小限に保つ。
2. 乱用されているグローバル変数やハードコードされた定数を整理し、設定値はすべて `get(g:, 'ripgrep_*', ...)` を介して参照する。
3. ヘルプコメントを `" Function: ripgrep#job#start()` のような `:*` 形式で追記し、`:help` での検索性を高める。
4. parser の戻り値仕様とデータ構造を README およびヘルプに明記し、欠損や例外パスをテストで確認できるようにする。
5. コードの重複や未使用ロジック (`s:root_keywords` など) を洗い出し、段階的に削除または統合する。

### 今後のタスク例
- `ripgrep#job#start()` の引数検証とエラー処理を共通化。
- parser の `parse()` でチャンク分割された JSON ラインの結合ロジックを改善し、テストケースを追加。
- Neovim/Vim 双方で動作確認するための自動テスト環境 (Docker など) を整備。



