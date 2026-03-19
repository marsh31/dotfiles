

" gj {{{2
"
" nnoremap gj                        gj<plug>(submode-gjk-enter)
" nnoremap gk                        gk<plug>(submode-gjk-enter)
" 
" nnoremap <plug>(submode-gjk-enter) <cmd>echo 'Enter submode'<cr><plug>(submode-gjk)
" 
" nnoremap <plug>(submode-gjk)j      gj<plug>(submode-gjk)
" nnoremap <plug>(submode-gjk)k      gk<plug>(submode-gjk)
" 
" nnoremap <plug>(submode-gjk><esc>  <plug>(submode-gjk-leave)
" nnoremap <plug>(submode-gjk)       <plug>(submode-gjk-leave)
" nnoremap <plug>(submode-gjk-leave) <cmd>echo 'Leave submode'<cr>


" scroll {{{2
" scroll enter
" nnoremap zz                             zz<plug>(submode-scroll-enter)
" nnoremap zt                             zt<plug>(submode-scroll-enter)
" nnoremap zb                             zb<plug>(submode-scroll-enter)
" nnoremap zl                             zl<plug>(submode-scroll-enter)
" nnoremap zh                             zh<plug>(submode-scroll-enter)
" nnoremap <plug>(submode-scroll-enter)   <cmd>echo 'Enter submode scroll'<cr><plug>(submode-scroll)
" 
" " scroll body
" nnoremap <plug>(submode-scroll)z        zt<plug>(submode-scroll-sub-t)
" nnoremap <plug>(submode-scroll-sub-t)z  zb<plug>(submode-scroll-sub-b)
" nnoremap <plug>(submode-scroll-sub-b)z  zz<plug>(submode-scroll)
" 
" nnoremap <plug>(submode-scroll-sub-t)t  zt<plug>(submode-scroll)
" nnoremap <plug>(submode-scroll-sub-t)b  zb<plug>(submode-scroll)
" nnoremap <plug>(submode-scroll-sub-t)l  zl<plug>(submode-scroll)
" nnoremap <plug>(submode-scroll-sub-t)h  zh<plug>(submode-scroll)
" 
" nnoremap <plug>(submode-scroll-sub-b)t  zt<plug>(submode-scroll)
" nnoremap <plug>(submode-scroll-sub-b)b  zb<plug>(submode-scroll)
" nnoremap <plug>(submode-scroll-sub-b)l  zl<plug>(submode-scroll)
" nnoremap <plug>(submode-scroll-sub-b)h  zh<plug>(submode-scroll)
" 
" nnoremap <plug>(submode-scroll)t        zt<plug>(submode-scroll)
" nnoremap <plug>(submode-scroll)b        zb<plug>(submode-scroll)
" nnoremap <plug>(submode-scroll)l        zl<plug>(submode-scroll)
" nnoremap <plug>(submode-scroll)h        zh<plug>(submode-scroll)
" 
" " scroll leave
" nnoremap <plug>(submode-scroll><cr>     <plug>(submode-scroll-leave)
" nnoremap <plug>(submode-scroll><esc>    <plug>(submode-scroll-leave)
" nnoremap <plug>(submode-scroll)         <plug>(submode-scroll-leave)
" nnoremap <plug>(submode-scroll-leave)   <cmd>echo 'Leave submode'<cr>


" submode: tab mode {{{1
" 
" memo {{{2
" これ、ステータスラインを自作したことで、自分のやりたかったことが実現できたので、ちょっと真面目に考える。
" 共通化できる部分は共通化するべきだと思う。  
" 例えば、timeout, timeoutlen, ttimeout, ttimeoutlen
" とかをバックアップして、リストアするみたいな制御は
" サブモード全体として共通化したい機能だと思う。
" でも、サブモード固有で遷移したときにしたこともあると思う。
" なので、そこは切り分けて設計してもいいじゃないかな。  
"
" あと、仮に他のサブモードから遷移してくるパターンがあると思っていて、
" その場合もケアする。
"
" state diagram {{{2
"
"   * user action
"        * core action
"             * user defined action(tab)          * user defined action(winmv)
"                                                
" some key (entering submode action)                
"   |                                             
"   `---> 1. <plug>(submode-enter-core)             
"        |  コアの初期化処理                           元のサブモードに戻る。
"        |  オプションを設定したりとか。             でもモードを戻さずにサブモードから
"        ↓                                          抜ける可能性もある。
"        2. core entering-submode-action  <---------------------------------------------+
"        `---> 2. <plug>(submode-enter-tab)                                            |
"             |  サブモード特有の初期化処理                                           |
"        +-----+                                                                       |
"        ↓                                                                             |
"        3. <plug>(submode-tab)  <--------------+                                      |
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
" func {{{2

let s:submode_name = ''

fun! GetSubmodeName()
  return s:submode_name
endfun


fun!  s:echo_submode_name()
  echohl ModeMsg
  echo '-- Submode: ' .. s:submode_name .. ' --'
  echohl None
endfun

fun!  s:on_entering_submode(submode)
  let s:submode_name       = a:submode
  let s:origin_timeout     = &timeout
  let s:origin_timeoutlen  = &timeoutlen
  let s:origin_ttimeout    = &ttimeout
  let s:origin_ttimeoutlen = &ttimeoutlen
endfun


fun!  s:on_leaving_submode(submode)
  let s:submode_name = ''
  let &timeout       = s:origin_timeout
  let &timeoutlen    = s:origin_timeoutlen
  let &ttimeout      = s:origin_ttimeout
  let &ttimeoutlen   = s:origin_ttimeoutlen
endfun


fun! s:tabmode_enter()
  call s:on_entering_submode('tab')
  call s:oldstash_store()
endfun

fun! s:tabmode_body()
  let s:submode_name = "tab"
  call s:echo_submode_name()
endfun

fun! s:tabmode_leave()
  call s:on_leaving_submode('tab')
  echo 'Leave submode: tab'
endfun

fun! s:tabmode_lock()
  echo "Locking submode: tab"
endfun

fun! s:oldstash_store()
  let s:oldstash = v:oldfiles
  let s:oldindex = 0
  let s:oldmax   = len(s:oldstash)
endfun

fun! s:oldstash_pop()
  if s:oldindex >=# s:oldmax
    return ''
  endif

  let l:oldfile = s:oldstash[s:oldindex]
  let s:oldindex = s:oldindex + 1
  return l:oldfile
endfun



" keymap {{{2
" enter tab mode
" nnoremap <silent> gt                             <plug>(submode-tab-enter)
" nnoremap <silent> gT                             <plug>(submode-tab-enter)
" nnoremap <silent> <plug>(submode-tab-enter)      <cmd>call <sid>tabmode_enter()<cr><plug>(submode-tab)
" 
" 
" " tab mode body
" nnoremap <silent> <plug>(submode-tab)T           gT<plug>(submode-tab)
" nnoremap <silent> <plug>(submode-tab)t           gt<plug>(submode-tab)
" 
" nnoremap <silent> <plug>(submode-tab)h           <cmd>call <sid>tabmode_body()<cr>gT<plug>(submode-tab)
" nnoremap <silent> <plug>(submode-tab)l           <cmd>call <sid>tabmode_body()<cr>gt<plug>(submode-tab)
" 
" nnoremap <silent> <plug>(submode-tab)H           <cmd>tabfirst<cr><plug>(submode-tab)
" nnoremap <silent> <plug>(submode-tab)L           <cmd>tablast<cr><plug>(submode-tab)
" 
" nnoremap <silent> <plug>(submode-tab)w           <cmd>write<cr><plug>(submode-tab)
" nnoremap <silent> <plug>(submode-tab)q           <cmd>tabclose<cr><plug>(submode-tab)
" nnoremap <silent> <plug>(submode-tab)c           <cmd>tab sp<cr><plug>(submode-tab)
" nnoremap <silent> <plug>(submode-tab)n           <cmd>tabnew<cr><plug>(submode-tab)
" 
" nnoremap <silent> <plug>(submode-tab)o           <cmd>exec 'tabnew ' .. <sid>oldstash_pop()<cr><plug>(submode-tab)


" tab mode body nop
" タブモードを待機するためのキー
" nnoremap <silent> <plug>(submode-tab)j           <cmd>echo 'Enter submode: tab nop'<cr><plug>(submode-tab)
" nnoremap <silent> <plug>(submode-tab)k           <cmd>echo 'Enter submode: tab nop'<cr><plug>(submode-tab)
" nnoremap <silent> <plug>(submode-tab)g           <cmd>echo 'Enter submode: tab nop'<cr><plug>(submode-tab)
" 
" nnoremap <silent> <plug>(submode-tab)<space>     <cmd>call <sid>tabmode_lock()<cr><plug>(submode-tab)


" leave tab mode
" nnoremap <silent> <plug>(submode-tab)<cr>        <plug>(submode-tab-leave)
" nnoremap <silent> <plug>(submode-tab)<esc>       <plug>(submode-tab-leave)
" nnoremap <silent> <plug>(submode-tab)            <plug>(submode-tab-leave)
" nnoremap <silent> <plug>(submode-tab-leave)      <cmd>call <sid>tabmode_leave()<cr>


" END: {{{1
" vim: set ft=vim
