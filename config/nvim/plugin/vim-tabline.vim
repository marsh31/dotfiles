
let s:nonames = {
      \ '':   '[No Name]',
      \ 'qf': '[Quickfix]'
      \ }


" 各タブページのカレントバッファ名+αを表示
fun! s:tabpage_label(n)
  " t:title と言う変数があったらそれを使う
  let title = gettabvar(a:n, 'title')
  if title !=# ''
    return title
  endif

  " タブページ内のバッファのリスト
  let bufnrs = tabpagebuflist(a:n)

  " カレントタブページかどうかでハイライトを切り替える
  let hi = a:n is tabpagenr() ? '%#TabLineSel#' : '%#TabLine#'

  " バッファが複数あったらバッファ数を表示
  let no = len(bufnrs)
  if no is 1
    let no = ''
  endif
  " タブページ内に変更ありのバッファがあったら '+' を付ける
  let mod = len(filter(copy(bufnrs), 'getbufvar(v:val, "&modified")')) ? '+' : ''
  let sp = (no . mod) ==# '' ? '' : ' '  " 隙間空ける

  " カレントバッファ
  let curbufnr = bufnrs[tabpagewinnr(a:n) - 1]  " tabpagewinnr() は 1 origin
  let fname = pathshorten(bufname(curbufnr))
  if fname ==# ''
    let ft = getbufvar(curbufnr, '&ft')
    let fname = get(s:nonames, ft, '[No Name]')
  endif
  let label = ' ' . no . mod . sp . fname . ' '

  return '%' . a:n . 'T' . hi . label . '%T%#TabLineFill#'
endfun


fun! s:tabpage_info() abort
  let date = strftime('%Y-%m-%d')
  let cwd = pathshorten(getcwd(0))

  let label = date . ' / ' . 'cwd: ' . cwd
  return label
endfun


fun! MakeTabLine()
  let titles = map(range(1, tabpagenr('$')), 's:tabpage_label(v:val)')
  let sep = ''  " タブ間の区切り
  let tabpages = join(titles, sep) . sep . '%#TabLineFill#%T'
  let info = s:tabpage_info()    " 好きな情報を入れる
  return tabpages . '%=' . info  " タブリストを左に、情報を右に表示
endfun

set tabline=%!MakeTabLine()



nmap <expr> <C-w><C-c> (len(tabpagebuflist()) ==# 1 && tabpagenr() !=# tabpagenr('$')) ? ':tabclose\|tabprev<cr>' : ':close<cr>'
nmap        <C-w><C-u> :<C-u>tab sp<CR>


nnoremap     <C-t>                   <Plug>(tabpage)

nmap         <Plug>(tabpage)q        :<C-u>tabclose <bar> tabprev<cr>
nmap         <Plug>(tabpage)<C-q>    :<C-u>tabclose <bar> tabprev<cr>


nmap         <Plug>(tabpage)<C-j>    :<C-u>tabnext<cr>
nmap         <Plug>(tabpage)<C-k>    :<C-u>tabprev<cr>
nmap         <Plug>(tabpage)j        :<C-u>tabnext<cr>
nmap         <Plug>(tabpage)k        :<C-u>tabprev<cr>


nmap <expr>  <Plug>(tabpage)<C-l>    tabpagenr() ==# tabpagenr('$') ? ':<C-u>0tabmove<cr>' : ':<C-u>tabmove +1<cr>'
nmap <expr>  <Plug>(tabpage)l        tabpagenr() ==# tabpagenr('$') ? ':<C-u>0tabmove<cr>' : ':<C-u>tabmove +1<cr>'

nmap <expr>  <Plug>(tabpage)<C-h>    tabpagenr() ==# 1 ? ':<C-u>$tabmove<cr>' : ':<C-u>tabmove -1<cr>'
nmap <expr>  <Plug>(tabpage)h        tabpagenr() ==# 1 ? ':<C-u>$tabmove<cr>' : ':<C-u>tabmove -1<cr>'


nmap         <Plug>(tabpage)0        :<C-u>tabfirst<cr>
nmap         <Plug>(tabpage)$        :<C-u>tablast<cr>
