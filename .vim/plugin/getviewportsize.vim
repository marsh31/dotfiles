"        1         2         3         4         5         6         7         8         9         10        11        12        13        14        15        16        17        18        19        20        21        22        23
"234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345
"  編集領域（= テキスト表示領域）の幅・高さを返すユーティリティ
" - 幅: 左ガター（fold/sign/number）を除いたテキスト領域の列数
" - 高さ: テキスト領域の行数（winbar/WinBar は除外される）
"
" 対応方針:
" - Vim 8.2.3627+ なら getwininfo().textoff を優先 (推奨)
" - それ以前は option を元に概算（signcolumn=auto は sign の有無で変動）

function! s:has_textoff() abort
  " textoff は patch 8.2.3627 で getwininfo() に追加された
  return has('patch-8.2.3627')
endfunction

function! s:signcolumn_width(winid) abort
  " 'signcolumn' は window-local
  let scl = getwinvar(a:winid, '&signcolumn')

  if scl ==# 'no'
    return 0
  endif

  if scl ==# 'number'
    " number 列に表示する。number 列が無い場合は auto 相当だが、
    " ここでは「専用 sign 列は出ない」として 0 を返し、number 側で吸収する。
    return 0
  endif

  if scl ==# 'yes'
    " sign column は 2 文字幅
    return 2
  endif

  " auto の場合: 実際に sign がある時だけ 2
  if scl ==# 'auto'
    if exists('*sign_getplaced')
      " 現在バッファに sign があるかをざっくり確認
      let placed = sign_getplaced(bufnr('%'))
      if !empty(placed) && has_key(placed[0], 'signs') && !empty(placed[0].signs)
        return 2
      endif
    endif
    return 0
  endif

  " 不明値は保守的に 0
  return 0
endfunction

function! s:numbercol_width(winid) abort
  let nu  = getwinvar(a:winid, '&number')
  let rnu = getwinvar(a:winid, '&relativenumber')

  if !nu && !rnu
    return 0
  endif

  let nuw = getwinvar(a:winid, '&numberwidth')

  " numberwidth は「数字 + 右側の 1 文字スペース」を含む最小幅。
  " 実際は必要に応じて拡張される。
  let digits =
        \ nu ? strlen(string(line('$')))
        \    : strlen(string(winheight(a:winid)))

  " digits + 1(数字とテキストの間のスペース) が必要幅の目安
  return max([nuw, digits + 1])
endfunction

function! s:calc_textoff_fallback(winid) abort
  let fdc = getwinvar(a:winid, '&foldcolumn')
  let scl = s:signcolumn_width(a:winid)
  let num = s:numbercol_width(a:winid)
  return fdc + scl + num
endfunction

function! GetViewportSize(...) abort
  let winid = a:0 ? a:1 : win_getid()
  let info = getwininfo(winid)
  if empty(info)
    return {'width': -1, 'height': -1}
  endif

  let win_w = info[0].width
  let win_h = winheight(winid) " winbar/WinBar を除外
  if s:has_textoff() && has_key(info[0], 'textoff')
    let textoff = info[0].textoff
  else
    let textoff = s:calc_textoff_fallback(winid)
  endif

  return {
        \ 'width':  win_w - textoff,
        \ 'height': win_h,
        \ 'winwidth':  win_w,
        \ 'textoff': textoff,
        \ }
endfunction


function! GetWindowSize() abort
  tab sp
  let info = GetViewportSize()
  close
  return info
endfunction



