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

let s:cpp_highlight = {
      \ 'c': g:guten_tag_hi_cpp_class,
      \ 'g': g:guten_tag_hi_cpp_enum,
      \ 'e': g:guten_tag_hi_cpp_enum_member,
      \ 'f': g:guten_tag_hi_cpp_function,
      \ 'd': g:guten_tag_hi_cpp_macro,
      \ 'm': g:guten_tag_hi_cpp_member,
      \ 'n': g:guten_tag_hi_cpp_namespace,
      \ 's': g:guten_tag_hi_cpp_struct,
      \ 't': g:guten_tag_hi_cpp_typedef,
      \ 'u': g:guten_tag_hi_cpp_union,
      \ 'v': g:guten_tag_hi_cpp_variable,
      \ }

" --- D --- "

call guten_tag#option#DefOpt('guten_tag_hi_d_alias',
      \ ['Identifier', 'Typedef'])
call guten_tag#option#DefOpt('guten_tag_hi_d_class',
      \ ['Identifier', 'Structure'])
call guten_tag#option#DefOpt('guten_tag_hi_d_enum',
      \ ['Identifier', 'Structure'])
call guten_tag#option#DefOpt('guten_tag_hi_d_enum_member',
      \ ['Identifier', 'Constant'])
call guten_tag#option#DefOpt('guten_tag_hi_d_external_var',
      \ ['Identifier', 'Identifier'])
call guten_tag#option#DefOpt('guten_tag_hi_d_function',
      \ ['Identifier', 'Function'])
call guten_tag#option#DefOpt('guten_tag_hi_d_interface',
      \ ['Identifier', 'Structure'])
call guten_tag#option#DefOpt('guten_tag_hi_d_member',
      \ ['Identifier', 'Identifier'])
call guten_tag#option#DefOpt('guten_tag_hi_d_mixin',
      \ ['Identifier', 'Structure'])
call guten_tag#option#DefOpt('guten_tag_hi_d_module',
      \ ['Identifier', 'Constant'])
call guten_tag#option#DefOpt('guten_tag_hi_d_struct',
      \ ['Identifier', 'Structure'])
call guten_tag#option#DefOpt('guten_tag_hi_d_template',
      \ ['Identifier', 'Structure'])
call guten_tag#option#DefOpt('guten_tag_hi_d_union',
      \ ['Identifier', 'Structure'])
call guten_tag#option#DefOpt('guten_tag_hi_d_variable',
      \ ['Identifier', 'Identifier'])

let s:d_highlight = {
      \ 'a': g:guten_tag_hi_d_alias,
      \ 'c': g:guten_tag_hi_d_class,
      \ 'g': g:guten_tag_hi_d_enum,
      \ 'e': g:guten_tag_hi_d_enum_member,
      \ 'x': g:guten_tag_hi_d_external_var,
      \ 'f': g:guten_tag_hi_d_function,
      \ 'i': g:guten_tag_hi_d_interface,
      \ 'm': g:guten_tag_hi_d_member,
      \ 'X': g:guten_tag_hi_d_mixin,
      \ 'M': g:guten_tag_hi_d_module,
      \ 's': g:guten_tag_hi_d_struct,
      \ 'T': g:guten_tag_hi_d_template,
      \ 'u': g:guten_tag_hi_d_union,
      \ 'v': g:guten_tag_hi_d_variable,
      \ }

" --- Go --- "

call guten_tag#option#DefOpt('guten_tag_hi_go_package',
      \ ['Identifier', 'Identfier'])
call guten_tag#option#DefOpt('guten_tag_hi_go_function',
      \ ['Identifier', 'Function'])
call guten_tag#option#DefOpt('guten_tag_hi_go_constant',
      \ ['Identifier', 'Constant'])
call guten_tag#option#DefOpt('guten_tag_hi_go_type', 
      \ ['Identifier', 'Identifier'])
call guten_tag#option#DefOpt('guten_tag_hi_go_variable',
      \ ['Identifier', 'Identifier'])
call guten_tag#option#DefOpt('guten_tag_hi_go_struct',
      \ ['Identifier', 'Structure'])
call guten_tag#option#DefOpt('guten_tag_hi_go_interface',
      \ ['Identifier', 'Structure'])
call guten_tag#option#DefOpt('guten_tag_hi_go_member',
      \ ['Identifier', 'Identifier'])

let s:go_highlight = {
      \ 'p': g:guten_tag_hi_go_package,
      \ 'f': g:guten_tag_hi_go_function,
      \ 'c': g:guten_tag_hi_go_constant,
      \ 't': g:guten_tag_hi_go_type,
      \ 'v': g:guten_tag_hi_go_variable,
      \ 's': g:guten_tag_hi_go_struct,
      \ 'i': g:guten_tag_hi_go_interface,
      \ 'm': g:guten_tag_hi_go_member,
      \ 'M': g:guten_tag_hi_go_member,
      \ }

" --- Java --- "

call guten_tag#option#DefOpt('guten_tag_hi_java_annotation',
      \ ['Identifier', 'Identifier'])
call guten_tag#option#DefOpt('guten_tag_hi_java_class', 
      \ ['Identifier', 'Structure'])
call guten_tag#option#DefOpt('guten_tag_hi_java_enum',
      \ ['Identifier', 'Structure'])
call guten_tag#option#DefOpt('guten_tag_hi_java_enum_member',
      \ ['Identifier', 'Identifier'])
call guten_tag#option#DefOpt('guten_tag_hi_java_field',
      \ ['Identifier', 'Identifier'])
call guten_tag#option#DefOpt('guten_tag_hi_java_interface',
      \ ['Identifier', 'Structure'])
call guten_tag#option#DefOpt('guten_tag_hi_java_method',
      \ ['Identifier', 'Function'])

let s:java_highlight = {
      \ 'a': g:guten_tag_hi_java_annotation,
      \ 'c': g:guten_tag_hi_java_class,
      \ 'g': g:guten_tag_hi_java_enum,
      \ 'e': g:guten_tag_hi_java_enum_member,
      \ 'f': g:guten_tag_hi_java_field,
      \ 'i': g:guten_tag_hi_java_interface,
      \ 'm': g:guten_tag_hi_java_method,
      \ }

" --- Lisp --- "

call guten_tag#option#DefOpt('guten_tag_hi_lisp_function',
      \ ['Identifier', 'Function'])

let s:lisp_highlight = {
      \ 'f': g:guten_tag_hi_lisp_function,
      \ }

" --- Lua --- "

call guten_tag#option#DefOpt('guten_tag_hi_lua_function',
      \ ['Identifier', 'Function'])

let s:lua_highlight = {
      \ 'f': g:guten_tag_hi_lua_function,
      \ }

" --- Perl --- "

call guten_tag#option#DefOpt('guten_tag_hi_perl_constant',
      \ ['Identifier', 'Constant'])
call guten_tag#option#DefOpt('guten_tag_hi_perl_format',
      \ ['Identifier', 'String'])
call guten_tag#option#DefOpt('guten_tag_hi_perl_label',
      \ ['Identifier', 'Label'])
call guten_tag#option#DefOpt('guten_tag_hi_perl_package',
      \ ['Identifier', 'Identifier'])
call guten_tag#option#DefOpt('guten_tag_hi_perl_sub',
      \ ['Identifier', 'Function'])

let s:perl_highlight = {
      \ 'c': g:guten_tag_hi_perl_constant,
      \ 'f': g:guten_tag_hi_perl_format,
      \ 'l': g:guten_tag_hi_perl_label,
      \ 'p': g:guten_tag_hi_perl_package,
      \ 's': g:guten_tag_hi_perl_sub
      \ }

" --- Python --- "

call guten_tag#option#DefOpt('guten_tag_hi_py_class',
      \ ['Identifier', 'Structure'])
call guten_tag#option#DefOpt('guten_tag_hi_py_function',
      \ ['Identifier', 'Function'])
call guten_tag#option#DefOpt('guten_tag_hi_py_member',
      \ ['Identifier', 'Label'])
call guten_tag#option#DefOpt('guten_tag_hi_py_variable',
      \ ['Identifier', 'Identifier'])

let s:python_highlight = {
      \ 'c': g:guten_tag_hi_py_class,
      \ 'f': g:guten_tag_hi_py_function,
      \ 'm': g:guten_tag_hi_py_member,
      \ 'v': g:guten_tag_hi_py_variable,
      \ }

" --- R --- "

call guten_tag#option#DefOpt('guten_tag_hi_r_function',
      \ ['Identifier', 'Function'])
call guten_tag#option#DefOpt('guten_tag_hi_r_global',
      \ ['Identifier', 'Label'])

let s:r_highlight = {
      \ 'f': g:guten_tag_hi_r_function,
      \ 'g': g:guten_tag_hi_r_global,
      \ }

" --- Ruby --- "

call guten_tag#option#DefOpt('guten_tag_hi_ruby_class',
      \ ['Identifier', 'Structure'])
call guten_tag#option#DefOpt('guten_tag_hi_ruby_method',
      \ ['Identifier', 'Function'])
call guten_tag#option#DefOpt('guten_tag_hi_ruby_singleton',
      \ ['Identifier', 'Function'])

let s:ruby_highlight = {
      \ 'c': g:guten_tag_hi_ruby_class,
      \ 'm': g:guten_tag_hi_ruby_method,
      \ 'S': g:guten_tag_hi_ruby_singleton,
      \ }

" --- Tying this all together --- "

let s:highlight_groups = {
      \ 'C': s:c_highlight,
      \ 'C++': s:cpp_highlight,
      \ 'D': s:d_highlight,
      \ 'Go': s:go_highlight,
      \ 'Java': s:java_highlight,
      \ 'Lisp': s:lisp_highlight,
      \ 'Lua': s:lua_highlight,
      \ 'Perl': s:perl_highlight,
      \ 'Python': s:python_highlight,
      \ 'R': s:r_highlight,
      \ 'Ruby': s:ruby_highlight,
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
