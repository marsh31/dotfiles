" 
"
"
"

let s:sign_name = "markdown info"
let s:sign_dict = #{
      \ linehl: "WildMenu",
      \ priority: 100,
      \ text: ' ',
      \ texthl: 'Normal',
      \ }


fun! SignInfo()
  let result = searchpair(':::note info', '', ':::', 'n')
  echo string(result)
endfun

