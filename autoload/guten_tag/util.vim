" Utility functions
" Maintainer: Michail Pevnev <mpevnev@gmail.com>
" License: Vim's license

" Get a fully qualified tag name
function! guten_tag#util#QualifiedName(tag, separator)
  let l:parents = []
  while a:tag isnot# v:null
    l:parents = [a:tag] + l:parents
    a:tag = a:tag.parent
  endwhile
  return join(map(l:parents, {t -> t.name}), a:separator)
endfunction
