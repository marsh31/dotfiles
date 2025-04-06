## Table of Contents

<!-- mtoc start {{{ -->

* [方針](#方針)
* [事前準備](#事前準備)
* [Plugins](#plugins)
  * [(廃止検討): lukas-reineke/headlines.nvim](#廃止検討-lukas-reinekeheadlinesnvim)
  * [(コンフィグ見直し): jakewvincent/mkdnflow.nvim](#コンフィグ見直し-jakewvincentmkdnflownvim)
  * [(コンフィグ見直し): iamcco/markdown-preview.nvim](#コンフィグ見直し-iamccomarkdown-previewnvim)
  * [(廃止): MeanderingProgrammer/render-markdown.nvim](#廃止-meanderingprogrammerrender-markdownnvim)
  * [(使用): bullets-vim/bullets.vim](#使用-bullets-vimbulletsvim)
  * [(使用): hedyhli/markdown-toc.nvim](#使用-hedyhlimarkdown-tocnvim)

<!-- mtoc end }}} -->


## 方針

- Markdownファイルの編集をサポートして余計な邪魔はしないプラグインを選択する。  
- デフォルトのキーマップなどの置き換えも基本しない。  
  (より上位機能があれば、割当をする。)
- 追加の機能を割り当てる際にも使用していないキーマップに割当をする。  


## 事前準備

`vim.g["markdown_recommended_style"] = 0` / `g:markdown_recommended_style = 0` を設定する。


## Plugins

| 状態               | プラグイン                                                                                                |
| ------------------ | --------------------------------------------------------------------------------------------------------- |
| (コンフィグ見直し) | [MeanderingProgrammer/render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim) |
| (コンフィグ見直し) | [jakewvincent/mkdnflow.nvim](https://github.com/jakewvincent/mkdnflow.nvim)                               |
| (コンフィグ見直し) | [iamcco/markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim)                           |
| (廃止検討)         | [lukas-reineke/headlines.nvim](https://github.com/lukas-reineke/headlines.nvim)                           |
| (使用)             | [bullets-vim/bullets.vim](https://github.com/bullets-vim/bullets.vim)                                     |
| (使用)             | [hedyhli/markdown-toc.nvim](https://github.com/hedyhli/markdown-toc.nvim)                                 |


### (廃止検討): [lukas-reineke/headlines.nvim](https://github.com/lukas-reineke/headlines.nvim)

ヘッドラインとかのハイライトはかっこいいんだけど、可読性が下がって編集がしづらくなってしまう。  
半年くらい使ってみたけど自分は慣れなかったので、その点はやだ。  
ただ、他のコードブロックとかは感触良かった。  
作者が新規機能を追加しないことを明言しているし、[MeanderingProgrammer/render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim)を推奨している。  
[MeanderingProgrammer/render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim)乗り換えを検討中。


### (コンフィグ見直し): [jakewvincent/mkdnflow.nvim](https://github.com/jakewvincent/mkdnflow.nvim)

余計な機能が多くあるけどカスタムの幅が多くありそう。  
自分が使えていないだけかもしれないから継続利用。と、コンフィグの見直しをしたらいいかも。  


### (コンフィグ見直し): [iamcco/markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim)

多分不要な検討なんだけど、プレビューにちょっと不満がある。  
なので、もしかしたら別の移行先を検討するかも。  


### (廃止): [MeanderingProgrammer/render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim)

これ、[lukas-reineke/headlines.nvim](https://github.com/lukas-reineke/headlines.nvim)から移行する。  
ビミョー。編集画面と閲覧画面が大きく変わりすぎてしまうため、編集用じゃないと私は思った。  
余計な機能が多いかな。  
シンプルに`Markdown`の色つけとかだけしてくれるだけで十分なのでいらない。  


### (使用): [bullets-vim/bullets.vim](https://github.com/bullets-vim/bullets.vim)

すごくいい。いらない機能を捨てることもできるし、マークダウン以外のファイルタイプにも使えるのが良い。  
[config](lua/default/plugins/bullets_vim.lua) にコンフィグを用意。  


| mode | Key          | Keybind                           |
| ---- | ------------ | --------------------------------- |
| imap | `<M-cr>`     | `<Plug>(bullets-newline)`         |
| imap | `<C-cr>`     | `<Plug>(bullets-newline)`         |
| vmap | `gN`         | `<Plug>(bullets-renumber)`        |
| nmap | `gN`         | `<Plug>(bullets-renumber)`        |
| imap | `<C-t>`      | `<Plug>(bullets-demote)`          |
| nmap | `>>`         | `<Plug>(bullets-demote)`          |
| vmap | `>`          | `<Plug>(bullets-demote)`          |
| imap | `<C-d>`      | `<Plug>(bullets-promote)`         |
| nmap | `>>`         | `<Plug>(bullets-promote)`         |
| vmap | `>`          | `<Plug>(bullets-promote)`         |
| nmap | `<leader>x`  | `<Plug>(bullets-toggle-checkbox)` |


### (使用): [hedyhli/markdown-toc.nvim](https://github.com/hedyhli/markdown-toc.nvim)

邪魔をしないので、結構いいかも。  
`Mtoc`でTable Of Contentsを作れるのがいい。  
`Mtoc u`で更新ができる。  


