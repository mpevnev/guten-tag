" Utility functions
" Maintainer: Michail Pevnev <mpevnev@gmail.com>
" License: Vim's license

" Get the last portion of a qualified name
function! guten_tag#util#LastNamePart(name, pattern)
  return split(a:name, a:pattern, 1)[-1]
endfunction

" Get a fully qualified tag name
function! guten_tag#util#QualifiedName(tag, separator)
  let l:path = []
  let l:tag = a:tag
  while l:tag isnot# v:null
    let l:path = [l:tag] + l:path
    let l:tag = l:tag.parent
  endwhile
  return join(map(l:path, 'v:val.name'), a:separator)
endfunction
