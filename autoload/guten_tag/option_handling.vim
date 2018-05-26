" Option-manipulating functions
" Maintainer: Michail Pevnev <mpevnev@gmail.com>
" License: Vim's license

" Set a default for an option.
function! guten_tag#DefOpt(option, default)
  let l:name = 'g:' . a:option
  if !exists(l:name)
    exec 'let ' . l:name . ' = a:default'
  endif
endfunction

" Modify an option by passing its value to a modification function and setting
" it to the function's return value.
function! guten_tag#ModOpt(option, modification)
  let l:name = 'g:' . a:option
  if !exists(l:name)
    return
  endif
  exec 'let l:cur_value = ' . l:name
  exec 'let ' . l:name . ' = a:modification(l:cur_value)'
endfunction
