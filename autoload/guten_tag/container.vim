" Functions to find containers for other tags
" Maintainer: Michail Pevnev <mpevnev@gmail.com>
" License: Vim's license

" --- Main stuff --- "

" Return true if the tag can have a parent
function! guten_tag#container#CanHaveParent(tag)
  if a:tag.fields.language ==# ''
    return 0
  endif
  if !has_key(s:can_have_parent_mapping, a:tag.fields.language)
    return 0
  endif
  return s:can_have_parent_mapping[a:tag.fields.language](a:tag)
endfunction

" Return true if the first tag can contain the second one.
function! guten_tag#container#Contains(container, tag)
  if a:container is# a:tag
    return 0
  endif
  if a:container.fields.language !=# a:tag.fields.language
    return 0
  endif
  let l:lang = a:container.fields.language
  if !has_key(s:contains_mapping, l:lang)
    return 0
  endif
  return s:contains_mapping[l:lang](a:container, a:tag)
endfunction

" --- ASM --- "

function! s:ContainsAsm(container, tag)
  return 0
endfunction

" --- C --- "

function! s:CanHaveParentC(tag)
  let l:kind = guten_tag#tag#TagKind(a:tag)
  if l:kind =~# '\vd|f|g|h|l|p|s|t|u|v|x|z|L'
    return 0
  endif
  if l:kind ==# 'e'
    return has_key(a:tag.fields, 'enum')
  elseif l:kind ==# 'm'
    return guten_tag#util#HasAny(a:tag.fields, ['struct', 'union'])
  else
    return 0
  endif
endfunction

function! s:ContainsC(container, tag)
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
function! s:CanHaveParentCPP(tag)
  let l:kind = guten_tag#tag#TagKind(a:tag)
  if l:kind ==# 'e'
    return has_key(a:tag.fields, 'enum')
  elseif l:kind =~# '\vf|g|m|p|s|u|c'
    return guten_tag#util#HasAny(a:tag.fields, ['struct', 'class', 'namespace'])
  else
    return 0
  endif
endfunction

function! s:ContainsCPP(container, tag)
  let l:contkind = guten_tag#tag#TagKind(a:container)
  let l:tagkind = guten_tag#tag#TagKind(a:tag)
  if l:contkind =~# '\vd|e|f|h|l|m|p|t|v|x|z|L|N|U'
    return 0
  endif
  let l:contname = guten_tag#util#QualifiedName(a:container, '::')
  if l:contkind ==# 'g' && l:tagkind ==# 'e'
    return get(a:tag.fields, 'enum', '') ==# l:contname
  elseif l:contkind ==# 'c'
    return get(a:tag.fields, 'class', '') ==# l:contname
  elseif l:contkind ==# 's'
    return get(a:tag.fields, 'struct', '') ==# l:contname
  elseif l:contkind ==# 'n'
    return get(a:tag.fields, 'namespace', '') ==# l:contname
  else
    return 0
  endif
endfunction

" --- D --- "

function! s:CanHaveParentD(tag)
  return guten_tag#util#HasAny(a:tag.fields, ['struct', 'class', 'template', 'mixin',
        \ 'namespace', 'module', 'enum', 'union', 'function', 'interface'])
endfunction

function! s:ContainsD(container, tag)
  let l:contkind = guten_tag#tag#TagKind(a:container)
  if l:contkind =~# '\va|e|x|l|m|p|v|V'
    return 0
  endif
  let l:contname = guten_tag#util#QualifiedName(a:container, '.')
  if l:contkind ==# 'c'
    return get(a:tag.fields, 'class', '') ==# l:contname
  elseif l:contkind ==# 'g' 
    return get(a:tag.fields, 'enum', '') ==# l:contname
  elseif l:contkind ==# 'f'
    return get(a:tag.fields, 'function', '') ==# l:contname
  elseif l:contkind ==# 'i'
    return get(a:tag.fields, 'interface', '') ==# l:contname
  elseif l:contkind ==# 'X'
    return get(a:tag.fields, 'mixin', '') ==# l:contname
  elseif l:contkind ==# 'M'
    return get(a:tag.fields, 'module', '') ==# l:contname
  elseif l:contkind ==# 'n'
    return get(a:tag.fields, 'namespace', '') ==# l:contname
  elseif l:contkind ==# 's'
    return get(a:tag.fields, 'struct', '') ==# l:contname
  elseif l:contkind ==# 'T'
    return get(a:tag.fields, 'template', '') ==# l:contname
  elseif l:contkind ==# 'u'
    return get(a:tag.fields, 'union', '') ==# l:contname
  else
    return 0
  endif
endfunction

" --- Go --- "

function! s:CanHaveParentGo(tag)
  return guten_tag#util#HasAny(a:tag.fields, ['struct', 'package', 'interface',
        \ 'type', 'unknown'])
endfunction

function! s:ContainsGo(container, tag)
  let l:contkind = guten_tag#tag#TagKind(a:container)
  let l:contname = guten_tag#util#QualifiedName(a:container, '.')
  if l:contkind ==# 'p'
    return get(a:tag.fields, 'package', '') ==# l:contname
  elseif l:contkind ==# 't'
    return get(a:tag.fields, 'type', '') ==# l:contname
  elseif l:contkind ==# 's'
    return get(a:tag.fields, 'struct', '') ==# l:contname
  elseif l:contkind ==# 'i'
    return get(a:tag.fields, 'interface', '') ==# l:contname
  else
    return get(a:tag.fields, 'unknown', '') ==# l:contname
  endif
endfunction

" --- Java --- "

function! s:CanHaveParentJava(tag)
  return guten_tag#util#HasAny(a:tag.fields, ['class', 'enum', 'interface'])
endfunction

function! s:ContainsJava(container, tag)
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

" --- JavaScript --- "

function! s:CanHaveParentJavaScript(tag)
  return has_key(a:tag.fields, 'class')
endfunction

function! s:ContainsJavaScript(container, tag)
  let l:contkind = guten_tag#tag#TagKind(a:container)
  if l:contkind =~# '\vf|m|p|C|v|g'
    return 0
  endif
  let l:contname = guten_tag#util#QualifiedName(a:container, '.')
  return get(a:tag.fields, 'class') ==# l:contname
endfunction

" --- Lisp --- "

function! s:ContainsLisp(container, tag)
  " This is kind of ridiculous, but 'f' is actually the *only* tag kind for
  " Lisp. I hope the guys from Universal Tags will add more sometime.
  return 0
endfunction

" --- Lua --- "

function! s:ContainsLua(container, tag)
  " Yeah, same here - no tags for anything.
  return 0
endfunction

" --- Perl --- "

function! s:ContainsPerl(container, tag)
  return 0
endfunction

" --- Python --- "
function! s:CanHaveParentPython(tag)
  return has_key(a:tag.fields, 'class')
endfunction

function! s:ContainsPython(container, tag)
  let l:contkind = guten_tag#tag#TagKind(a:container)
  let l:tagkind = guten_tag#tag#TagKind(a:tag)
  if l:contkind =~# '\vn|v|I|i|x|z|l|f'
    return 0
  endif
  return get(a:tag.fields, 'class', '') ==# a:container.name
endfunction

" --- R --- "

function! s:ContainsR(container, tag)
  return 0
endfunction

" --- Ruby --- "

function! s:CanHaveParentRuby(tag)
  return guten_tag#util#HasAny(a:tag.fields, ['class', 'module'])
endfunction
 
function! s:ContainsRuby(container, tag)
  let l:contkind = guten_tag#tag#TagKind(a:container)
  let l:tagkind = guten_tag#tag#TagKind(a:tag)
  if l:contkind ==# 'c'
    let l:class = get(a:tag.fields, 'class', '')
    let l:parentname = guten_tag#util#QualifiedName(a:container, '.')
    return l:class ==# l:parentname
  elseif l:contkind ==# 'm'
    let l:module = get(a:tag.fields, 'module', '')
    let l:parentname = guten_tag#util#QualifiedName(a:container, '.')
    return l:module ==# l:parentname
  else
    return 0
  endif
endfunction

" --- Rust --- "

function! s:CanHaveParentRust(tag)
  return guten_tag#util#HasAny(a:tag.fields, ['enum', 'implementation', 'struct',
        \ 'module', 'function', 'interface'])
endfunction

function! s:ContainsRust(container, tag)
  let l:contkind = guten_tag#tag#TagKind(a:container)
  let l:tagkind = guten_tag#tag#TagKind(a:tag)
  if l:contkind =~# '\vc|t|v|M|m|e|P'
    return 0
  endif
  let l:contname = guten_tag#util#QualifiedName(a:container, '::')
  if l:contkind ==# 'n'
    return get(a:tag.fields, 'module', '') ==# l:contname
  elseif l:contkind ==# 's'
    return get(a:tag.fields, 'struct', '') ==# l:contname
  elseif l:contkind ==# 'i'
    return get(a:tag.fields, 'interface', '') ==# l:contname
  elseif l:contkind ==# 'f'
    return get(a:tag.fields, 'function', '') ==# l:contname
  elseif l:contkind ==# 'c'
    return get(a:tag.fields, 'implementation', '') ==# l:contname
  elseif l:contkind ==# 'g' && l:tagkind ==# 'e'
    return get(a:tag.fields, 'enum', '') ==# l:contname
  else
    return 0
  endif
endfunction

" --- Tying this all together --- "

let s:can_have_parent_mapping = {
      \ 'C': function('s:CanHaveParentC'),
      \ 'C++': function('s:CanHaveParentCPP'),
      \ 'D': function('s:CanHaveParentD'),
      \ 'Go': function('s:CanHaveParentGo'),
      \ 'Java': function('s:CanHaveParentJava'),
      \ 'JavaScript': function('s:CanHaveParentJavaScript'),
      \ 'Python': function('s:CanHaveParentPython'),
      \ 'Ruby': function('s:CanHaveParentRuby'),
      \ 'Rust': function('s:CanHaveParentRust'),
      \ }

let s:contains_mapping = {
      \ 'Asm': function('s:ContainsAsm'),
      \ 'C': function('s:ContainsC'),
      \ 'C++': function('s:ContainsCPP'),
      \ 'D': function('s:ContainsD'),
      \ 'Go': function('s:ContainsGo'),
      \ 'Java': function('s:ContainsJava'),
      \ 'JavaScript': function('s:ContainsJavaScript'),
      \ 'Lisp': function('s:ContainsLisp'),
      \ 'Lua': function('s:ContainsLua'),
      \ 'Perl': function('s:ContainsPerl'),
      \ 'Python': function('s:ContainsPython'),
      \ 'R': function('s:ContainsR'),
      \ 'Ruby': function('s:ContainsRuby'),
      \ 'Rust': function('s:ContainsRust'),
      \ }
