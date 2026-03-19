"
"
"
" map       gt                    (BeforeEnteringWith)(BeforeEntering)(Enter)  サブモード入るためのキー
"                                                                              
" MAP       (BeforeEnteringWith)  (anykey)                                     サブモードに入る前のキー入力 
" nnoremap  (BeforeEntering)      (Fun entering action)                        サブモードに入る前の関数コール
" map       (Enter)               (Fun BeforeAction)(Prefix)                   サブモードコマンド実行前の関数コールして待ち
" map       (Prefix)              (Leave)                                      タイムアウト
" map       (Prefix)(anykey)      (Fun BeforeLeave)(Leave)                     サブモードから抜ける
" map       (Prefix)(anykey)      (RhsForLhs)(Enter)                           サブモードのコマンドを実行して待ちに行く
" MAP       (RhsForLhs)           (Rhs)                                        サブモードのコマンド実行
"
"
" 更新
"
" map       gt                    (BeforeEnteringWith)(BeforeEntering)(Enter)  サブモード入るためのキー
"                                                                              
" MAP       (BeforeEnteringWith)  (anykey)                                     サブモードに入る前のキー入力 
" nnoremap  (BeforeEntering)      (Fun entering action)                        サブモードに入る前の関数コール
" map       (Enter)               (Fun BeforeAction)(Prefix)                   サブモードコマンド実行前の関数コールして待ち
" map       (Prefix)              (Fun Timeout?)(Leave)                        タイムアウト
" map       (Prefix)(anykey)      (Fun BeforeLeave)(Leave)                     サブモードから抜ける
" map       (Prefix)(anykey)      (RhsForLhs)(Enter)                           サブモードのコマンドを実行して待ちに行く
" MAP       (RhsForLhs)           (Rhs)                                        サブモードのコマンド実行


let s:mode = ""
let s:time = -1


fun! s:before_action()
  echomsg "-- before --"
  let s:time = reltime()
endfun


fun! s:try_timeout()
  echomsg "-- try timeout --"
  echomsg "timeout type: " .. (reltimefloat(reltime(s:time)) * 1000) .. "ms"
endfun


nmap <Leader>t           <cmd>call <sid>before_action()<cr><plug>(test-wait)
nmap <plug>(test-wait)   <cmd>call <sid>try_timeout()<cr>
nmap <plug>(test-wait)s  <cmd>echomsg "-- action --"<cr><cmd>call <sid>before_action()<cr><plug>(test-wait)


