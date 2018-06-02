" Highlighting support
" Maintainer: Michail Pevnev <mpevnev@gmail.com>
" License: Vim's license

if !has('nvim') || exists('g:guten_tag_done_highlighting')
  finish
endif
let g:guten_tag_done_highlighting = 1

" --- C --- "

call guten_tag#option#DefOpt('guten_tag_hi_c_enum',
      \ ['Identifier', 'Structure'])
call guten_tag#option#DefOpt('guten_tag_hi_c_enum_member',
      \ ['Identifier', 'Identifier'])
call guten_tag#option#DefOpt('guten_tag_hi_c_function',
      \ ['Identifier', 'Function'])
call guten_tag#option#DefOpt('guten_tag_hi_c_macro',
      \ ['Identifier', 'Macro'])
call guten_tag#option#DefOpt('guten_tag_hi_c_member',
      \ ['Identifier', 'Label'])
call guten_tag#option#DefOpt('guten_tag_hi_c_struct',
      \ ['Identifier', 'Structure'])
call guten_tag#option#DefOpt('guten_tag_hi_c_typedef', 
      \ ['Identifier', 'Typedef'])
call guten_tag#option#DefOpt('guten_tag_hi_c_union',
      \ ['Identifier', 'Structure'])
call guten_tag#option#DefOpt('guten_tag_hi_c_variable',
      \ ['Identifier', 'Constant'])

let s:c_highlight = {
      \ 'g': g:guten_tag_hi_c_enum,
      \ 'e': g:guten_tag_hi_c_enum_member,
      \ 'f': g:guten_tag_hi_c_function,
      \ 'd': g:guten_tag_hi_c_macro,
      \ 'm': g:guten_tag_hi_c_member,
      \ 's': g:guten_tag_hi_c_struct,
      \ 't': g:guten_tag_hi_c_typedef,
      \ 'u': g:guten_tag_hi_c_union,
      \ 'v': g:guten_tag_hi_c_variable,
      \ }

" --- C++ --- "

call guten_tag#option#DefOpt('guten_tag_hi_cpp_class',
      \ ['Identifier', 'Structure'])
call guten_tag#option#DefOpt('guten_tag_hi_cpp_enum',
      \ ['Identifier', 'Structure'])
call guten_tag#option#DefOpt('guten_tag_hi_cpp_enum_member',
      \ ['Identifier', 'Identifier'])
call guten_tag#option#DefOpt('guten_tag_hi_cpp_function',
      \ ['Identifier', 'Function'])
call guten_tag#option#DefOpt('guten_tag_hi_cpp_macro',
      \ ['Identifier', 'Macro'])
call guten_tag#option#DefOpt('guten_tag_hi_cpp_member',
      \ ['Identifier', 'Label'])
call guten_tag#option#DefOpt('guten_tag_hi_cpp_namespace',
      \ ['Identifier', 'Structure'])
call guten_tag#option#DefOpt('guten_tag_hi_cpp_struct',
      \ ['Identifier', 'Structure'])
call guten_tag#option#DefOpt('guten_tag_hi_cpp_typedef',
      \ ['Identifier', 'Typedef'])
call guten_tag#option#DefOpt('guten_tag_hi_cpp_union',
      \ ['Identifier', 'Structure'])
call guten_tag#option#DefOpt('guten_tag_hi_cpp_variable',
      \ ['Identifier', 'Identifier'])


" --- Tying this all together --- "

let s:highlight_groups = {
      \ 'C': s:c_highlight
      \ }

" Set tag's highlighting settings based on its language and kind
function! guten_tag#highlight#SetHighlighting(tag)
  let l:kind = guten_tag#tag#TagKind(a:tag)
  if a:tag.fields.language ==# '' || l:kind ==# ''
    return
  endif
  if !has_key(s:highlight_groups, a:tag.fields.language)
    let a:tag.kind_highlight = 'Identifier'
    let a:tag.name_highlight = 'Identifier'
    return
  endif
  let l:higroup = s:highlight_groups[a:tag.fields.language]
  if !has_key(l:higroup, l:kind)
    let a:tag.kind_highlight = 'Identifier'
    let a:tag.name_highlight = 'Identifier'
    return
  endif
  let [a:tag.kind_highlight, a:tag.name_highlight] = l:higroup[l:kind]
endfunction
