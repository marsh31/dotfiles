" NAME:   vim-markdown-frontmatter.vim
" AUTHOR: marsh
" NOTE:
"
" MarkdownでFrontMatterを扱うときに便利な関数です。
"
"

if exists('loaded_vim_markdown_frontmatter')
  finish
endif
let g:loaded_vim_markdown_frontmatter = 1

" Commands
command! HasFrontMatter   echo markdown#frontmatter#HasFrontMatter()
command! FrontMatterType  echo markdown#frontmatter#FrontMatterType()
command! FrontMatterRange echo markdown#frontmatter#FrontMatterRange()


fun! s:update_frontmatter_update() abort
  if !&modified
    return
  endif

  let fm = markdown#frontmatter#DetectFrontMatter()
  if fm.type !=# 'none'
    sp
    for l in range(fm.start, fm.end)
      call setline(l, substitute(getline(l), 'update: \zs\d\{4}-\d\{2}-\d\{2} \d\{2}:\d\{2}:\d\{2}\ze', strftime('%Y-%m-%d %H:%M:%S'), 'g'))
    endfor
    quit
  endif
endfun

fun! s:setup_front_matter_autocmds()
  augroup UpdateFrontMatter
    autocmd! * <buffer>
    autocmd BufWritePost <buffer> call s:update_frontmatter_update()
  augroup END
endfun


" markdown* のときだけセットアップ
augroup UpdateFrontMatterOnFileType
  autocmd!
  autocmd FileType markdown,markdown.pandoc call s:setup_front_matter_autocmds()
augroup END


