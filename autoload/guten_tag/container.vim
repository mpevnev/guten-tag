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

" --- ASM --- "

function! s:CanContainAsm(container, tag)
  return 0
endfunction

" --- C --- "

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

" --- C++ --- "

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

" --- D --- "

function! s:CanContainD(container, tag)
  let l:contkind = guten_tag#tag#TagKind(a:container)
  let l:tagkind = guten_tag#tag#TagKind(a:tag)
  if l:contkind =~# '\va|e|l|M|n|p|v|V'
    return 0
  endif
  if l:contkind ==# 'c'
    return get(a:tag.fields, 'class', '') ==# a:container.name
  elseif l:contkind ==# 'g'
    return get(a:tag.fields, 'enum', '') ==# a:container.name
  elseif l:contkind ==# 'f'
    return get(a:tag.fields, 'function', '') ==# a:container.name
  elseif l:contkind ==# 'i'
    return get(a:tag.fields, 'interface', '') ==# a:container.name
  elseif l:contkind ==# 'X'
    return get(a:tag.fields, 'mixin', '') ==# a:container.name
  elseif l:contkind ==# 's'
    return get(a:tag.fields, 'struct', '') ==# a:container.name
  elseif l:contkind ==# 'T'
    return get(a:tag.fields, 'template', '') ==# a:container.name
  elseif l:contkind ==# 'u'
    return get(a:tag.fields, 'union', '') ==# a:container.name
  else
    return 0
  endif
endfunction

" --- Java --- "

function! s:CanContainJava(container, tag)
  let l:contkind = guten_tag#tag#TagKind(a:container)
  let l:tagkind = guten_tag#tag#TagKind(a:tag) 
  if l:contkind =~# '\va|f|l|m|p'
    return 0
  endif
  if l:contkind ==# 'c'
    return get(a:tag.fields, 'class', '') ==# a:container.name
  elseif l:contkind ==# 'g'
    return get(a:tag.fields, 'enum', '') ==# a:container.name
  elseif l:contkind ==# 'i'
    return get(a:tag.fields, 'interface', '') ==# a:container.name
  else
    return 0
  endif
endfunction

" --- Python --- "

function! s:CanContainPython(container, tag)
  let l:contkind = guten_tag#tag#TagKind(a:container)
  let l:tagkind = guten_tag#tag#TagKind(a:tag)
  if l:contkind =~# '\vn|v|I|i|x|z|l|f'
    return 0
  endif
  return get(a:tag.fields, 'class', '') ==# a:container.name
endfunction

" --- Tying this all together --- "

let s:container_mapping = {
      \ 'Asm': function('s:CanContainAsm'),
      \ 'C': function('s:CanContainC'),
      \ 'C++': function('s:CanContainCPP'),
      \ 'D': function('s:CanContainD'),
      \ 'Java': function('s:CanContainJava'),
      \ 'Python': function('s:CanContainPython'),
      \ }
