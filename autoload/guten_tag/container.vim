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
  let l:contkind = guten_tag#tag#TagKind(a:container)
  let l:tagkind = guten_tag#tag#TagKind(a:tag)
  if l:contkind =~# '\vd|e|f|h|l|m|p|t|v|x|z|L'
    return 0
  endif
  if l:contkind ==# 'g' && l:tagkind ==# 'e'
    return get(a:tag.fields, 'enum', '') ==# a:container.name
  elseif l:contkind ==# 's' && l:tagkind ==# 'm'
    return get(a:tag.fields, 'struct', '') ==# a:container.name
  elseif l:contkind ==# 'u' && l:tagkind ==# 'm'
    return get(a:tag.fields, 'union', '') ==# a:container.name
  else
    return 0
  endif
endfunction

" --- C++ container logic --- "

function! s:CanContainCPP(container, tag)
  let l:contkind = guten_tag#tag#TagKind(a:container)
  let l:tagkind = guten_tag#tag#TagKind(a:tag)
  if l:contkind =~# '\vd|e|f|h|l|m|p|t|v|x|z|L|N|U'
    return 0
  endif
  if l:contkind ==# 'g' && l:tagkind ==# 'e'
    return get(a:tag.fields, 'enum', '') ==# a:container.name
  elseif l:contkind ==# 'c' && l:tagkind ==# 'm'
    return get(a:tag.fields, 'class', '') ==# a:container.name
  elseif l:contkind ==# 's' && l:tagkind ==# 'm'
    return get(a:tag.fields, 'struct', '') ==# a:container.name
  else
    return 0
  endif
endfunction

" --- Tying this all together --- "

let s:container_mapping = {
      \ 'C': function('s:CanContainC')
      \ 'C++': function('s:CanContainCPP')
      \ }
