

let s:comp_enable = v:false

function! s:MarkdownTagComplete(findstart, base) abort
  if a:findstart
    let l:line = getline('.')
    let l:col  = col('.')
    let l:before = strpart(l:line, 0, l:col - 1)

    " パターン1: #tag の開始位置を返す
    let l:m = matchstrpos(l:before, '#\(\k\|-\|/\)*$')
    if l:m[1] != -1
      " '#' の直後の単語開始位置
      return l:m[1] + 2
    endif

    " パターン2: 'tags:' の直後（front-matter）
    let l:n = matchstrpos(l:before, 'tags:\s*[\[\-\s]*\(\k\|-\|/\)*$')
    if l:n[1] != -1
      " 'tags:' 後の語の開始位置（置換対象の先頭）
      " ざっくり末尾単語の開始を探す
      let l:s = l:col - 1
      while l:s > 0 && matchstr(l:line[l:s - 1], '\k\|-\|/') != ''
        let l:s -= 1
      endwhile
      return l:s + 1
    endif

    return -2 " 補完なし
  else
    " 辞書を読み込んで prefix でフィルタ
    let l:path = expand('~/.config/markdown_tags.txt')
    if !filereadable(l:path)
      return []
    endif
    let l:tags = readfile(l:path)
    let l:base = a:base
    return filter(copy(l:tags), {_, v -> v =~? '^' . escape(l:base, '\')})
  endif
endfunction


if s:comp_enable
  augroup markdown_tags_complete
    autocmd!
    autocmd FileType markdown setlocal completefunc=<SID>MarkdownTagComplete
    " メニューが見やすいように
    autocmd FileType markdown setlocal completeopt=menu,menuone,noselect
    " 好みでトリガーを割り当て（Ctrl-Space が空いていれば便利）
    autocmd FileType markdown inoremap <buffer> <C-Space> <C-x><C-u>
  augroup END
endif
