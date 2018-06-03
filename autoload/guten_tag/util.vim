" Utility functions
" Maintainer: Michail Pevnev <mpevnev@gmail.com>
" License: Vim's license

" Get a fully qualified tag name
function! guten_tag#util#QualifiedName(tag, separator)
  let l:parents = []
  let l:tag = a:tag
  while l:tag isnot# v:null
    let l:parents = [l:tag] + l:parents
    let l:tag = l:tag.parent
  endwhile
  return join(map(l:parents, 'v:val.name'), a:separator)
endfunction
