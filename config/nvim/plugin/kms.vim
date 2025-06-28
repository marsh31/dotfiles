"
" Vim KMS - Knowledge Management System Core
"

if exists('g:loaded_kms')
  finish
endif
let g:loaded_kms = 1

" ============================
" ユーザー設定用のパス
" ============================
if !exists('g:kms_knowledge_dir')
  let g:kms_knowledge_dir = expand('~/knowledge')
endif
if !exists('g:kms_template_dir')
  let g:kms_template_dir = expand('~/.vim/templates')
endif

" テンプレ変数を読み込み（あれば）
if filereadable(expand("~/.vim/template_vars.vim"))
  execute 'source ~/.vim/template_vars.vim'
endif

" ============================
" :KnowledgeNew <type> - ノート作成コマンド
" ============================
function! s:KnowledgeNew(type)
  let l:ts = strftime("%Y%m%d%H%M%S")
  let l:filename = g:kms_knowledge_dir . '/' . l:ts . '.md'
  execute 'edit ' . fnameescape(l:filename)
  execute 'Template ' . a:type
endfunction

command! -nargs=1 KnowledgeNew call s:KnowledgeNew(<f-args>)


" ============================
" :KnowledgeSearch <query> - 検索コマンド
" ============================
function! s:KnowledgeSearch(...) abort
  let l:args = join(a:000, ' ')
  let l:command = 'python3 ' . expand('<sfile>:p:h') . '/pythonx/kms_core.py search ' . shellescape(l:args)
  let l:lines = systemlist(l:command)
  if v:shell_error
    echohl ErrorMsg | echom "検索失敗: " . l:lines[0] | echohl None
    return
  endif
  call fzf#run(fzf#wrap({
        \ 'source': l:lines,
        \ 'sink': function('s:OpenNoteFromFzf'),
        \ 'options': '--prompt="KMS> "'
        \ }))
endfunction

function! s:OpenNoteFromFzf(line)
  let l:file = matchstr(a:line, '\v\[(\d{14}\.md)\]', 1)
  if !empty(l:file)
    execute 'edit' g:kms_knowledge_dir . '/' . l:file
  endif
endfunction

command! -nargs=+ KnowledgeSearch call s:KnowledgeSearch(<f-args>)


" ============================
" :KnowledgeIndex - キャッシュ構築コマンド
" ============================
function! s:KnowledgeIndex()
  let l:command = 'python3 ' . expand('<sfile>:p:h') . '/pythonx/kms_core.py index'
  let l:output = systemlist(l:command)
  echo join(l:output, "\n")
endfunction

command! KnowledgeIndex call s:KnowledgeIndex()


" ============================
" :KnowledgeHeaderEdit - YAMLヘッダーをJSON形式で編集
" ============================
function! s:KnowledgeHeaderEdit()
  let l:note_path = expand('%:p')
  if !filereadable(l:note_path)
    echohl ErrorMsg | echom 'ノートファイルが開かれていません。' | echohl None
    return
  endif
  let l:cmd = 'python3 ' . expand('<sfile>:p:h') . '/pythonx/kms_core.py extract ' . shellescape(l:note_path)
  let l:json = systemlist(l:cmd)
  if v:shell_error
    echohl ErrorMsg | echom 'ヘッダー抽出に失敗しました。' | echohl None
    return
  endif
  new
  setlocal buftype=acwrite bufhidden=wipe noswapfile filetype=json
  let b:linked_note_path = l:note_path
  call setline(1, l:json)
  autocmd BufWriteCmd <buffer> call s:ApplyHeaderToNote()
  echo '✅ ヘッダーをJSON形式で編集できます。保存で元ノートに反映されます。'
endfunction

command! KnowledgeHeaderEdit call s:KnowledgeHeaderEdit()

function! s:ApplyHeaderToNote()
  if !exists('b:linked_note_path')
    echohl ErrorMsg | echom '元ノートパスが見つかりません。' | echohl None
    return
  endif
  let l:tmpfile = tempname()
  call writefile(getline(1, '$'), l:tmpfile)
  let l:cmd = 'python3 ' . expand('<sfile>:p:h') . '/pythonx/kms_core.py apply ' . shellescape(b:linked_note_path) . ' ' . l:tmpfile
  let l:out = systemlist(l:cmd)
  if v:shell_error
    echohl ErrorMsg | echom 'ヘッダー更新に失敗しました。' | echohl None
  else
    echo '✅ ノートにヘッダーを反映しました'
    quit
  endif
endfunction
