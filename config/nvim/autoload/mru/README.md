# MRU (Most Recently Used)

## TOC

<!-- mtoc start {{{ -->

* [Usage](#usage)
* [Architecture](#architecture)

<!-- }}} mtoc end -->


## Usage




## Architecture

```txt

  +---------------+                     +-----------------+
  | Vim User App  |                     | MRU Manager     |
  |               |                     |                 | Add files        +-----------+
  |               |                     |                 |----------------->| MRU File  |
  |               |                     | - isLocked      |                  |           |
  |               | API and file path   | - mruFilePath   | Delete files     |           |
  |               |-------------------->| - mruFiles      |----------------->|           |
  |               |                     |                 |                  |           |
  |               | Json Object         |                 | Load files       |           |
  |               |<--------------------|                 |<-----------------|           |
  |               |                     |                 |                  +-----------+
  |               |                     |                 |
  +---------------+                     +-----------------+
                                           MRU ManagerはMRU Fileへのアクセスを管理する機能を持つ。
                                          Vim User ApplicationからのMRUデータへのファイルの追加、削除、読み込み
                                          を制御する。また、ファイルへのアクセス権のロック機能を持ち、
                                          リクエストに対して、失敗を返すことがある。
```





