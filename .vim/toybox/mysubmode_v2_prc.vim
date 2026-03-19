" NAME:   mysubmode_v2_prc.vim
" AUTHOR: marsh
" NOTE:
"
" chart / api {{{
" state diagram {{{2
" これ思ったんだけど、なんでサブモードの終了処理をしてはいけない？
" 終了して正常終了した後に、再度入り直すようにしたら良いのでは？
"
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
"   |\   if other key is event key or leave key  |                                      |
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
"
"


" handmake {{{1

" functions {{{2

fun! s:submode_core_enter(submode)                          " {{{3
  " 1. core enter
  echomsg "--- start ---"
  echomsg "submode core enter: " .. a:submode
endfun


fun! s:submode_user_enter()                                 " {{{3
  " 2. user enter
  echomsg "submode user enter"
endfun


fun! s:submode_core_wait(submode)                           " {{{3
  " 3. user leave
  echomsg "submode core waiting: " .. a:submode
endfun


fun! s:submode_user_event_action(key)                       " {{{3
  " 5. action
  if type(a:key) == v:t_number
    echomsg "submode user event action: " .. nr2char(a:key)
  elseif type(a:key) == v:t_string
    if "\<bs>" == a:key
      echomsg "submode user event action: <bs>"
    else
      echomsg "submode user event action: UNKNOWN str"
    endif
  else
    echomsg "submode user event action: UNKNOWN type"
  endif
endfun


fun! s:submode_user_leave()                                 " {{{3
  " 6. user leave
  echomsg "submode user leave"
endfun



fun! s:submode_core_leave(submode)                          " {{{3
  " 7. user leave
  echomsg "submode core leave: " .. a:submode
endfun


" keys {{{2

" sub mode init (submodeA) {{{3
" nmap      <silent>  <Leader>f                       <plug>(sme-submodeA)
" 
" nmap      <silent>  <plug>(sme-submodeA)            <cmd>call <sid>submode_core_enter('submodeA')<cr><plug>(sme-user-submodeA)    
" nmap      <silent>  <plug>(sme-user-submodeA)       <cmd>call <sid>submode_user_enter()<cr><plug>(sme-wait-submodeA)
" 
" nmap      <silent>  <plug>(sme-wait-submodeA)       <cmd>call <sid>submode_core_wait('submodeA')<cr><plug>(smw-submodeA)
" nmap      <silent>  <plug>(smw-submodeA)            <plug>(sml-submodeA)
" nmap      <silent>  <plug>(sml-submodeA)            <plug>(sml-user-submodeA)<cmd>call <sid>submode_core_leave('submodeA')<cr>
" nmap      <silent>  <plug>(sml-user-submodeA)       <cmd>call <sid>submode_user_leave()<cr>
" 
" 
" " add action key in sumode
" nnoremap  <silent>  <plug>(smw-submodeA)f           <cmd>call <sid>submode_user_event_action()<cr><plug>(sme-wait-submodeA)
" 
" " add leave key from submode
" nmap      <silent>  <plug>(smw-submodeA)<cr>        <plug>(sml-user-submodeA)
" nmap      <silent>  <plug>(smw-submodeA)<esc>       <plug>(sml-user-submodeA)
" 
" 
" " sub mode init (submodeB) {{{3
" nnoremap  <silent>  <Leader>g                       <plug>(sme-submodeB)
" 
" nnoremap  <silent>  <plug>(sme-submodeB)            <cmd>call <sid>submode_core_enter('submodeB')<cr><plug>(sme-user-submodeB)    
" nnoremap  <silent>  <plug>(sme-user-submodeB)       <cmd>call <sid>submode_user_enter()<cr><plug>(sme-wait-submodeB)
" 
" nnoremap  <silent>  <plug>(sme-wait-submodeB)       <cmd>call <sid>submode_core_wait('submodeB')<cr><plug>(smw-submodeB)
" nnoremap  <silent>  <plug>(smw-submodeB)            <plug>(sml-submodeB)
" nnoremap  <silent>  <plug>(sml-submodeB)            <plug>(sml-user-submodeB)<cmd>call <sid>submode_core_leave('submodeB')<cr>
" nnoremap  <silent>  <plug>(sml-user-submodeB)       <cmd>call <sid>submode_user_leave()<cr>
" 
" 
" " add action key in submode
" nnoremap  <silent>  <plug>(smw-submodeB)g           <cmd>call <sid>submode_user_event_action()<cr><plug>(sme-wait-submodeB)
" 
" " add leave key from submode
" nnoremap  <silent>  <plug>(smw-submodeB)<cr>        <plug>(sml-user-submodeB)
" nnoremap  <silent>  <plug>(smw-submodeB)<esc>       <plug>(sml-user-submodeB)


" sub mode init (submodeC) {{{3

nnoremap            <Leader>j                       <plug>(sme-submodeC)

nmap                <plug>(sme-submodeC)            <cmd>call <sid>submode_core_enter('submodeC')<cr><cmd>call <sid>submode_user_enter()<cr><plug>(smw-submodeC)
nmap                <plug>(smw-submodeC)            <cmd>call <sid>submode_core_wait('submodeC')<cr><plug>(sma-submodeC)

nmap                <plug>(sma-submodeC)j           <cmd>call <sid>submode_user_event_action(106)<cr><plug>(smw-submodeC)
nmap                <plug>(sma-submodeC)k           <plug>(sml-submodeC)<plug>(sme-submodeD)

nmap                <plug>(sma-submodeC)            <plug>(sml-submodeC)
nmap                <plug>(sma-submodeC)<cr>        <cmd>call <sid>submode_user_event_action(13)<cr><plug>(sml-submodeC)
nmap                <plug>(sma-submodeC)<esc>       <cmd>call <sid>submode_user_event_action(27)<cr><plug>(sml-submodeC)

nmap                <plug>(sml-submodeC)            <cmd>call <sid>submode_user_leave()<cr><cmd>call <sid>submode_core_leave('submodeC')<cr>


" sub mode init (submodeD) {{{3
"
" \<tab> : 9
" \<cr>  : 13
" \<esc> : 27
" j      : 106
" k      : 107
" \<bs>  : if char2nr("\<bs>") == 128 | echo xxx  | endif
"

nnoremap            <Leader>k                       <plug>(sme-submodeD)

nmap                <plug>(sme-submodeD)            <cmd>call <sid>submode_core_enter('submodeD')<cr><cmd>call <sid>submode_user_enter()<cr><plug>(smw-submodeD)
nmap                <plug>(smw-submodeD)            <cmd>call <sid>submode_core_wait('submodeD')<cr><plug>(sma-submodeD)

nmap                <plug>(sma-submodeD)            <plug>(sml-submodeD)

" additional {{{
nmap                <plug>(sma-submodeD)k           <cmd>call <sid>submode_user_event_action(107)<cr><plug>(smw-submodeD)
nmap                <plug>(sma-submodeD)j           <plug>(sml-submodeD)<plug>(sme-submodeC)

" }}}
" additional {{{
nmap                <plug>(sma-submodeD)<cr>        <cmd>call <sid>submode_user_event_action(13)<cr><plug>(sml-submodeD)
nmap                <plug>(sma-submodeD)<esc>       <cmd>call <sid>submode_user_event_action(27)<cr><plug>(sml-submodeD)
nmap                <plug>(sma-submodeD)<bs>        <cmd>call <sid>submode_user_event_action("\<bs>")<cr><plug>(sml-submodeD)
" }}}

nmap                <plug>(sml-submodeD)            <cmd>call <sid>submode_user_leave()<cr><cmd>call <sid>submode_core_leave('submodeD')<cr>


" automake {{{1

fun! s:mapname_entry(name)
  return printf("<plug>(sme-%s)", a:name)
endfun
fun! s:mapname_wait(name)
  return printf("<plug>(smw-%s)", a:name)
endfun
fun! s:mapname_action(name)
  return printf("<plug>(sma-%s)", a:name)
endfun
fun! s:mapname_leave(name)
  return printf("<plug>(sml-%s)", a:name)
endfun


fun! s:submode(name, mode, entry, action, leave)
  " nmap  <Leader>k             <plug>(sme-submodeD)
  "
  " x nmap  <plug>(sme-submodeD)  <cmd>call <sid>submode_core_enter('submodeD')<cr><cmd>call <sid>submode_user_enter()<cr><plug>(smw-submodeD)
  " x nmap  <plug>(smw-submodeD)  <cmd>call <sid>submode_core_wait('submodeD')<cr><plug>(sma-submodeD)
  " x nmap  <plug>(sma-submodeD)  <plug>(sml-submodeD)
  "
  " nmap  <plug>(sml-submodeD)  

  exec "nmap <silent> " .. s:mapname_entry(a:name) .. " " 
        \ .. printf('<cmd>call <sid>submode_core_enter("%s")<cr><cmd>call <sid>submode_user_enter()<cr>', a:name) .. s:mapname_wait(a:name)
  
  exec "nmap <silent> " .. s:mapname_wait(a:name) .. " " 
        \ .. printf('<cmd>call <sid>submode_core_wait("%s")<cr>', a:name) .. s:mapname_action(a:name)

  exec "nmap <silent> " .. s:mapname_action(a:name) .. " " ..  s:mapname_leave(a:name)

  exec "nmap <silent> " .. s:mapname_leave(a:name)  .. " "
        \ .. printf('<cmd>call <sid>submode_user_leave()<cr><cmd>call <sid>submode_core_leave("%s")<cr>', a:name)
endfun




call s:submode("submodeA", "n", {
      \ }, {
      \ }, {
      \ })










" anykey sample {{{1

let s:anykey_active  = v:false
let s:anykey_timer   = -1
let s:anykey_timeout = 2000

fun! AnyKeySample()
  if s:anykey_active
    return
  endif

  let s:anykey_active = v:true
  call s:restart_timer()

  echomsg 'ANYKEY: press any key, <Esc> to quit'
  while v:true
    let c = getchar(0)
    if s:anykey_active
      if c == 0
        continue
      endif

      call s:restart_timer()
      if c == 27
        call s:stop_anykey()
        break
      endif

      if c == 106
        echo "j"
        continue
      endif

      call s:handle_any_key(c)

    else
      echomsg "timeout"
      break
    endif

  endwhile
  echomsg "leave while loop"
endfun

fun! s:restart_timer() abort
  if s:anykey_timer != -1
    call timer_stop(s:anykey_timer)
  endif
  let s:anykey_timer = timer_start(s:anykey_timeout, function('<sid>on_timeout'))
endfun

fun! s:on_timeout(timer) abort
  if s:anykey_active
    let s:anykey_active = v:false
  endif
  echomsg "timeout anykey"
endfun

fun! s:handle_any_key(k) abort
  echomsg a:k
endfun

fun! s:stop_anykey() abort
  let s:anykey_active = v:false
  if s:anykey_timer != -1
    call timer_stop(s:anykey_timer)
    let s:anykey_timer = -1
  endif
  echomsg "End anykey"
endfun


" __END__  "{{{1
" vim: foldmethod=marker
