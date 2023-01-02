syntax match   customURLs "\(https\?\|ftp\)\(:\/\/[-_.!~*\'()a-zA-Z0-9;\/?:\@&=+\$,%#]\+\)" containedin=.*
hi link customURLs    Underlined

syntax match   customTodo "\(MARK\|TODO\|NOTE\):" containedin=.*Comment skipempty 
hi link customTodo    Todo


