" Functions to find containers for other tags
" Maintainer: Michail Pevnev <mpevnev@gmail.com>
" License: Vim's license

" --- Main stuff --- "

" Return true if the first tag can contain the second one.
function! guten_tag#container#CanContain(container, tag)
  if a:container.fields.language !=# a:tag.fields.language
    return 0
  endif
  let l:lang = a:container.fields.language
  if !has_key(s:container_mapping, l:lang)
    return 0
  endif
  return s:container_mapping[l:lang](a:container, a:tag)
endfunction

" Return a possible parent container for a tag, or null if there's none.
function! guten_tag#container#FindParent(tags, tag)
  for l:container in a:tags
    if guten_tag#container#CanContain(l:container, a:tag)
      return l:container
    endif
  endfor
  return v:null
endfunction

" --- C container logic --- "

function! s:CanContainC(container, tag)
  let l:cont = guten_tag#tag#TagKind(a:container)
  let l:tag = guten_tag#tag#TagKind(a:tag)
  if l:cont =~# '\vd|e|f|h|l|m|p|t|v|x|z|L'
    return 0
  endif
  if l:cont ==# 'g' && l:tag ==# 'e'
    return 1
  elseif l:cont =~# '\vs|u' && l:tag ==# 'm'
    return 1
  else
    return 0
  endif
endfunction

" --- Tying this all together --- "

let s:container_mapping = {
      \ 'C': function('s:CanContainC')
      \ }
