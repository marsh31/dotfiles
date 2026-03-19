" NAME:   mysubmode_v2
" AUTHOR: marsh
" NOTE:
"
" chart / api {{{
" state diagram {{{2
"
"   * user action
"        * core action
"             * user defined action(tab)          * user defined action(winmv)
"                                                
" some key (entering submode action)                
"   |                                             
"   `---> 1. <plug>(sme-submode)                    
"        |  コアの初期化処理                           元のサブモードに戻る。
"        |  オプションを設定したりとか。             でもモードを戻さずにサブモードから
"        |                                          抜ける可能性もある。
"        `---> 2. <plug>(submode-enter-tab) <-------------------------------------------+
"             |  サブモード特有の初期化処理                                           |
"        +-----+                                                                       |
"        ↓                                                                             |
"        3. <plug>(submode-tab)   <-------------+                                      |
"        |  call tabmode_body()                 |                                      |
"        |                                      |                                      |
"   +-----+  ここで、他のキーを待つ              |                                      |
"   |       waiting                             |                                      |
"   ↓                                           |                                      |
"   4. other key                                 |                                      |
"   |`   if other key is event key or leave key  |                                      |
"   | | or timeout.                              |                                      |
"   | |  打たれたkeyに応じて制御する。           |                                      |
"   | |  制御後に、 2. に遷移                    |                                      |
"   | |                                          |                                      |
"   | |  event key                               |                                      |
"   | `-------> 5. User Event Action   ----------+                                      |
"   |            <plug>(xxxx)                                                         |
"   |            <cmd>call xxxxx<cr>                                                  |
"   |            <cmd>tabnew<cr>                                                      |
"   |                                                                                 |
"   | (leaving key or timeout) or (other mode key)                                      |
"   `---------> 6. <plug>(submode-leave-tab) -----> 2'. <plug>(submode-enter-winmv)      |
"              |  call tabmode_leave()              3'. <plug>(submode-winmv)           |
"              |  サブモード特有の終了処理           4'. otherkey                       |
"         +-----+                                      5'. User Event Action             |
"         |                                     +------ 6'. <plug>(submode-leave-winmv) -+
"         ↓                                     |       ここらへんの状態は省略
"         7. <plug>(submode-leave-core) <-------+       ここらへんの状態切り替えは複雑そうに見えるけど、
"         |  コアとしての終了処理                       状態の切り替えが '''->core->tab->winmv->tab->core->''
"         |  submodeのために変更したオプション等の      と思うと難しくなさそう。
"         |  復帰とか
"         ↓
"         8. leaving submode
"
"
" keymap chain {{{2
"
" [some key]
"  -> <plug>(sme-core)
"   -> <plug>(sme-core)
"    -> <plug>(sme-core)
"     -> <plug>(sme-core)
"


" state: '' -> '<plug>(core)' -> 'submode' -> '<plug>(core)' -> ''
let s:submode_name = ''                  

fun! s:fail(msg)                                              " {{{2
  " 失敗出力をする。
  echohl ErrorMsg
  echomsg '[submode] ' .. a:msg
  echohl None
endfun


fun! s:stash_options()                   " {{{2
  " 
  let s:origin_timeout     = &timeout
  let s:origin_timeoutlen  = &timeoutlen
  let s:origin_ttimeout    = &ttimeout
  let s:origin_ttimeoutlen = &ttimeoutlen
endfun


fun! s:restore_options()                 " {{{2
  " 
  let s:origin_timeout     = &timeout
  let s:origin_timeoutlen  = &timeoutlen
  let s:origin_ttimeout    = &ttimeout
  let s:origin_ttimeoutlen = &ttimeoutlen
endfun



fun! s:echo_submode_name()               " {{{2
  " 
  echohl ModeMsg
  echo '-- Submode: ' .. s:submode_name .. ' --'
  echohl None
endfun



fun! s:change_mode(submode)              " {{{2
  " TODO: 内部実装を作り込む
  " exe "normal! \<Plug>(test)"

  if empty(s:submode_name) || empty(a:submode)
    " '' -> '<plug>(core)' -> 'submode'
    " 'submode' -> '<plug>(core)' -> ''


  elseif a:submode !=# s:submode_name
    " '<plug>(core)' -> 'submode'
    " or 'submode A' -> 'submode B'


  endif
endfun



fun! s:on_enter_core_exec(submode)       " {{{2
  " 1. submode-enter-core
  " TODO

  call s:stash_options()
  call s:change_mode(a:submode)
  call s:echo_submode_name()
endfun



fun! s:on_waiting_key()                  " {{{2
  " 3. submode-body
  " TODO
endfun



fun! s:on_leave_core_exec()              " {{{2
  " 7. submode-leave-core
  " TODO
endfun



" Interface {{{1

fun! CurrentSubmode()                                              " {{{2
  " 現在のサブモードの名称を返す。
  " これは、ステータスライン等で出力されることを想定している。
  return s:submode_name
endfun


fun! EnterSubmode(submode, mode, lhs, rhs, opts)                   " {{{2
  " キーマップを作り出すコマンド。
  " 1. <plug>(sme-core)
  " 2. <plug>(sme-<submode>)
  " 3. <plug>(smb-<submode>)
  " 4. <plug>(smb-<submode>)<lhs>
  " 5. <plug>(smb-<submode>)<lhs>     <rhs>
  " 6. <plug>(smb-<submode>)<lhs>     <plug>(sml-<submode>)
  " 7. <plug>(smb-<submode>)<lhs>     <plug>(sml-<submode>)
  "
  " submode : v:t_string : submode name
  " mode    : v:t_string : [cinsvx]
  " lhs     : v:t_string : サブモードに入るコマンド
  " rhs     : v:t_string : 即時に実行されるコマンド
  " opts    : v:dict     : 
  "
  " opts = {
  "   'flag':     v:t_string [bersu]
  "   'on_enter': v:t_func or v:t_string
  "   'on_leave': v:t_func or v:t_string
  " }
  "
  "

  if      type(a:submode) !=# v:t_string ||
        \ type(a:mode)    !=# v:t_string ||
        \ type(a:lhs)     !=# v:t_string ||
        \ type(a:rhs)     !=# v:t_string ||
        \ type(a:opts)    !=# v:t_dict

    call s:fail("argument type is not correct")
    return 1
  endif


  echomsg 'nnoremap ' .. a:lhs .. ' <cmd>call <sid>on_entering_submode()<cr><plug>(sme-submode)'
  echomsg 'nnoremap <plug>(sme-submode) ' .. ''
  echomsg 'nnoremap <plug>

  return s:submode_name
endfun



fun! ActionSubmode(submode, mode, lhs, rhs, opts)                  " {{{2
  return s:submode_name
endfun 
 

fun! LeaveSubmode(submode, mode, lhs, opts)                        " {{{2
  return s:submode_name
endfun 


fun! RestoreOption()                                               " {{{2
  " とりあえず、オプションだけ直す。
  call s:restore_options()
endfun

fun! UnmapSubmode(submode, mode, lhs, opts)                        " {{{2

endfun





" __END__  "{{{1
" vim: foldmethod=marker
