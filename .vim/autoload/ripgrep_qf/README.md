# ripgrep_qf


## TOC

<!-- mtoc start {{{ -->

* [Overview](#overview)
* [Usage](#usage)
* [doc](#doc)
  * [search.vim](#searchvim)
    * [ripgrep_qf#search#search](#ripgrep_qfsearchsearch)
    * [s:reset_handler](#sreset_handler)
    * [s:stdout_handler](#sstdout_handler)
    * [s:stderr_handler](#sstderr_handler)
    * [s:exit_handler](#sexit_handler)
  * [adapter.vim](#adaptervim)
    * [ripgrep_qf#adapter#convert](#ripgrep_qfadapterconvert)
    * [ripgrep_qf#adapter#add_match](#ripgrep_qfadapteradd_match)
    * [ripgrep_qf#adapter#finish](#ripgrep_qfadapterfinish)
    * [ripgrep_qf#adapter#reset](#ripgrep_qfadapterreset)
    * [s:process_begin](#sprocess_begin)
    * [s:process_match](#sprocess_match)
    * [s:process_end](#sprocess_end)
    * [s:process_textlike](#sprocess_textlike)

<!-- }}} mtoc end -->


## Overview

`ripgrep`で検索した結果を`quickfix`に流すためのインターフェース。  
２つのモジュールで構成される。  
- adapter.vim (アダプター)
- search.vim (ユーザーインターフェース)


## Usage

下記関数で実行できる。  
```vim
:call ripgrep_qf#search#search('-w --ignore-case foo')
```

より使いやすくするためには、コマンドを作ることもできる。  
```vim
command! -nargs=+ -complete=file Rg   :call ripgrep_qf#search#search('<q-args>')
command! -nargs=+ -complete=file Rgcf :call ripgrep_qf#search#search('<q-args>' . ' ' . expand('%'))
```


## doc

### search.vim

`ripgrep_qf#search#search`関数によって`ripgrep`に渡されるコマンド引数を指定する。  
`job`と`adapter`とデータを受け渡しする。  


#### ripgrep_qf#search#search

`ripgrep#job#start`に必要な値を渡す。  
ここで下記要素を渡す。  
- `ripgrep`に渡す引数
- `ripgrep`を実行するディレクトリのパス
- `callback`関数
  - `reset`  
    初期化関数。  

  - `on_stdout`  
    `ripgrep`の実行中の標準出力が渡される関数。  

  - `on_stderr`  
    `ripgrep`の実行中のエラー出力が渡される関数。  

  - `on_exit`  
    `ripgrep`の実行ジョブが終了したときに実行される関数。  

#### s:reset_handler

初期化関数。`job`/`adapter`/`parser`を初期化する。
ここは変えていはいけない。

#### s:stdout_handler

標準出力を受け取り、各要素をパーサーでオブジェクトにパースする。  
オブジェクトを`quickfix`に渡しやすい形にアダプターで変換する。  
変換した値をアダプターに渡して`quixkfix`に渡す。  


#### s:stderr_handler

エラーが発生したことをログに記憶する。  
その後、エラーメッセージを流してリセットする。  
TODO: 不具合として `[""]` が一度渡されている。  


#### s:exit_handler

終了メッセージをだす。


### adapter.vim

`quickfix`と`ripgrep`とをつなぐためのアダプター。  
インターフェースは４関数定義している。  
- `ripgrep_qf#adapter#convert`  
- `ripgrep_qf#adapter#add_match`  
- `ripgrep_qf#adapter#finish`  
- `ripgrep_qf#adapter#reset`  


#### ripgrep_qf#adapter#convert

`ripgrep`の検索結果のオブジェクトのデータを確認してタプル型で返す。  
タプル０はオブジェクトのタイプ、タプル１はオブジェクトデータ。  

タイプ, データ  
- file_begin, `process_begin`
- match, `process_match`
- file_end, `process_end`
- other


#### ripgrep_qf#adapter#add_match

`quickfix list`に値を設定する。  
このとき、初回の場合`quickfix window`を開く。  


#### ripgrep_qf#adapter#finish

`quickfix window`にタイトルを設定する。  
これは、ジョブが完了したときにコールされる。  


#### ripgrep_qf#adapter#reset

`quickfix list`を初期化する。  


#### s:process_begin

`ripgrep`で検索したファイルの先頭イベントを返す。


#### s:process_match

`ripgrep`の検索結果を整形して返す。


#### s:process_end

`ripgrep`で検索したファイルの最後イベントを返す。


#### s:process_textlike

テキストデータをデコードする。  
もし、文字列がテキストデータの場合、そのまま返す。  
もし、文字列がbytesデータの場合、デコードする。  


