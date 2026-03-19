" NAME:   debounce
" AUTHOR: marsh
"
" NOTE:
"
" vim#delay#debounce#set(fn, wait, args = []) {{{
"   発火する関数の文字列、待ち時間、発火させる関数の引数を渡して、
" 関数発火を設定する。発火する関数が再設定された場合、
" 関数コール回数を１増やして再度設定する。発火する関数が
" 待ち時間内で再設定されない場合、関数を発火させる。
"
" a:fn    関数の文字列。
" a:wait  関数発火までの待ち時間
" a:args  関数の引数
"
" 関数の引数の数は１以上であること。
" 第一引数には、関数の設定回数を渡す。
" 再設定されない場合は、１。
" 再設定されるごとに、上昇する。
"
" }}}
"
"
"


" s:debounce_config {{{
" 関数名ごとにタイマーコンフィグを保存する変数。
" タイマーハンドラと発火させる関数の呼ばれた回数を保存する。
"
" {
"   "<function name>": {
"     "timer": timer handler,
"     "count": 0
"   }
" }
"

let s:debounce_config = {}

" }}}

" vim#delay#debounce#set {{{
" s:debounce_config にタイマがセットされていればタイマを止めて
" s:debounce_config にタイマをセットする

function vim#delay#debounce#set(fn, wait, args = []) abort
  let count = 1
  let timer_name = string(a:fn)

  let config = get(s:debounce_config, timer_name, {})
  if config != {}
    let count = config.count + 1
    call timer_stop(config.timer)
    unlet! s:debounce_config[timer_name]
  endif

  let args = [ count ] + a:args
  let s:debounce_config[timer_name] = {
        \ "timer": timer_start(a:wait, {-> s:debounce_fire(a:fn, args) }),
        \ "count": count,
        \ }
endfunction

" }}}



"
" debounce_fire
" {{{

fun! s:debounce_fire(fn, args) abort
  let timer_name = string(a:fn)
  call call(a:fn, a:args)

  unlet! s:debounce_config[timer_name]
endfun

" }}}


" END {{{
" vim:tw=2 ts=2 et sw=2 wrap ff=unix fenc=utf-8 foldmethod=marker :
