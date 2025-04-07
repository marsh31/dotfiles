# ripgrep


## TOC

<!-- mtoc start {{{ -->

* [Overview](#overview)
* [Usage](#usage)

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

