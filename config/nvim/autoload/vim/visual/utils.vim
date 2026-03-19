

function! vim#visual#utils#getregionpos() abort
  let [_, flnr, fcol, _] = getpos("'<")
  let [_, elnr, ecol, _] = getpos("'>")

  return [ [ flnr, fcol ], [ elnr, ecol ] ]
endfunction


function! vim#visual#utils#getregiontext() abort
  let [ front, end ] = vim#visual#utils#getregionpos()
  let lines = getline(front[0], end[0])
  let lines[-1] = lines[-1][0:(end[1]-1)]
  let lines[0] = lines[0][(front[1]-1):]

  return lines
endfunction
