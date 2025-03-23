" NAME:   vim-log.vim
" AUTHOR: marsh
" NOTE:
"
"
" Log Output: {{{
" 
"      (Level) (Date)     (Time)   (Result) (Message)
"  Ex. [DEBUG] 2024-12-14 03:57:15 OK       this is test
"  Ex. [ERROR] 2024-12-14 03:57:17 NG       this is test
"
"   LogLevel:
"     - [DEBUG]    システムの動作に関するログ
"     - [INFO]     情報メッセージ
"     - [NOTICE]   正常ではあるが、重要な情報
"     - [WARN]     警告
"     - [ERROR]    問題がある情報
"     - [CRIT]     致命的な問題がある情報
"
" }}}
"
" Log Destination {{{
"
"   File only
"   /tmp/vim-<tag>/YYYY-MM-DD.log
"   
" }}}
" 


" 
" LogLevel
" {{{

let LogLevel = {
      \ 'DEBUG':  0,
      \ 'INFO':   1,
      \ 'NOTICE': 2,
      \ 'WARN':   3,
      \ 'ERROR':  4,
      \ 'CRIT':   5,
      \ }

let s:LogLevelText = [
      \ '[DEBUG] ',
      \ '[INFO]  ',
      \ '[NOTICE]',
      \ '[WARN]  ',
      \ '[ERROR] ',
      \ '[CRIT]  ',
      \ ]

" }}}


" 
" LogResult
" {{{

let LogResult = {
      \ "OK": 1,
      \ "NG": 2,
      \ }

" }}}
" 
" store
" created_dir
"
let s:LogConfig = {
      \ 'current_log_path': '',
      \ 'store': '',
      \ 'files': [],
      \ 'created_dir': v:false,
      \ 'level': LogLevel,
      \ }


" 
" LogConfig constructor
" {{{

fun! LogConfig(tag) abort
  let ret = deepcopy(s:LogConfig)
  let ret.store = printf("/tmp/vim-%s", a:tag)

  return ret
endfun

" }}}


"
" s:LogConfig.write
" {{{

fun! s:LogConfig.write(level, result, msg) abort
  call self.make_store_dir()
  call self.make_log_file()

  let write_msg = self.make_msg(a:level, a:result, a:msg)
  call writefile([write_msg], self.current_log_path, "a")
  call self.update_logbuffer()
endfun

" }}}


"
" s:LogConfig.debug
" {{{

fun! s:LogConfig.debug(result, msg) abort
  call self.write(self.level.DEBUG, a:result, a:msg)
endfun

" }}}


"
" s:LogConfig.info
" {{{

fun! s:LogConfig.info(result, msg) abort
  call self.write(self.level.INFO, a:result, a:msg)
endfun

" }}}


"
" s:LogConfig.notice
" {{{

fun! s:LogConfig.notice(result, msg) abort
  call self.write(self.level.NOTICE, a:result, a:msg)
endfun

" }}}


"
" s:LogConfig.warn
" {{{

fun! s:LogConfig.warn(result, msg) abort
  call self.write(self.level.WARN, a:result, a:msg)
endfun

" }}}


"
" s:LogConfig.error
" {{{

fun! s:LogConfig.error(result, msg) abort
  call self.write(self.level.ERROR, a:result, a:msg)
endfun

" }}}


"
" s:LogConfig.crit
" {{{

fun! s:LogConfig.crit(result, msg) abort
  call self.write(self.level.CRIT, a:result, a:msg)
endfun

" }}}


"
" s:LogConfig.make_store_dir
" {{{

fun! s:LogConfig.make_store_dir() abort
  if ! self.created_dir
    if ! isdirectory(self.store)
      call mkdir(self.store, 'p')
    endif
  endif

  let self.created_dir = v:true
endfun

" }}}


"
" s:LogConfig.make_log_file()
" {{{

fun! s:LogConfig.make_log_file() abort
  let today_logfile_name = printf("%s.log", strftime("%Y-%m-%d"))
  if index(self.files, today_logfile_name) == -1
    call add(self.files, today_logfile_name)

    let today_logfile_path = printf("%s/%s", self.store, today_logfile_name)
    let self.current_log_path = today_logfile_path

    if !(!empty(glob(today_logfile_path)) && !isdirectory(today_logfile_path))
      call writefile([], today_logfile_path, "b")
    endif
  endif
endfun

" }}}


"
" s:LogConfig.make_msg
" {{{

fun! s:LogConfig.make_msg(level, result, msg) abort
  let level_text = self.make_log_level_string(a:level)

  return printf("%s %s %s %s", level_text, strftime('%Y-%m-%d %H:%M:%S'), a:result, a:msg)
endfun

" }}}


"
" s:LgConfig.update_logbuffer
" {{{

fun! s:LogConfig.update_logbuffer() abort
  " TODO: is window has log buffer, do checktime
  " checktime
endfun

" }}}


" s:LogConfig.make_log_level_string
" {{{

fun! s:LogConfig.make_log_level_string(level)
  let level = a:level
  if level < 0 && len(s:LogLevelText) < level
    let level = 0
  endif

  return s:LogLevelText[level]
endfun

" }}}



" END {{{
" vim: foldmethod=marker
