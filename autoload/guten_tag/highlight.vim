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
      \ ['Identifier', 'Normal'])

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
      \ ['Identifier', 'Normal'])
call guten_tag#option#DefOpt('guten_tag_hi_d_function',
      \ ['Identifier', 'Function'])
call guten_tag#option#DefOpt('guten_tag_hi_d_interface',
      \ ['Identifier', 'Structure'])
call guten_tag#option#DefOpt('guten_tag_hi_d_member',
      \ ['Identifier', 'Normal'])
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
      \ ['Identifier', 'Normal'])

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
      \ ['Identifier', 'Normal'])
call guten_tag#option#DefOpt('guten_tag_hi_go_struct',
      \ ['Identifier', 'Structure'])
call guten_tag#option#DefOpt('guten_tag_hi_go_interface',
      \ ['Identifier', 'Structure'])
call guten_tag#option#DefOpt('guten_tag_hi_go_member',
      \ ['Identifier', 'Normal'])

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
      \ ['Identifier', 'Normal'])
call guten_tag#option#DefOpt('guten_tag_hi_java_field',
      \ ['Identifier', 'Normal'])
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

" --- JavaScript --- "

call guten_tag#option#DefOpt('guten_tag_hi_js_function',
      \ ['Identifier', 'Function'])
call guten_tag#option#DefOpt('guten_tag_hi_js_class',
      \ ['Identifier', 'Structure'])
call guten_tag#option#DefOpt('guten_tag_hi_js_method',
      \ ['Identifier', 'Function'])
call guten_tag#option#DefOpt('guten_tag_hi_js_property',
      \ ['Identifier', 'Function'])
call guten_tag#option#DefOpt('guten_tag_hi_js_constant',
      \ ['Identifier', 'Constant'])
call guten_tag#option#DefOpt('guten_tag_hi_js_global',
      \ ['Identifier', 'Normal'])
call guten_tag#option#DefOpt('guten_tag_hi_js_generator',
      \ ['Identifier', 'Function'])

let s:js_highlight = {
      \ 'f': g:guten_tag_hi_js_function,
      \ 'c': g:guten_tag_hi_js_class,
      \ 'm': g:guten_tag_hi_js_method,
      \ 'p': g:guten_tag_hi_js_property,
      \ 'C': g:guten_tag_hi_js_constant,
      \ 'v': g:guten_tag_hi_js_global,
      \ 'g': g:guten_tag_hi_js_generator,
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
      \ ['Identifier', 'Normal'])

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

" --- Rust --- "

call guten_tag#option#DefOpt('guten_tag_hi_rust_module',
      \ ['Identifier', 'Identifier'])
call guten_tag#option#DefOpt('guten_tag_hi_rust_struct',
      \ ['Identifier', 'Structure'])
call guten_tag#option#DefOpt('guten_tag_hi_rust_trait',
      \ ['Identifier', 'Structure'])
call guten_tag#option#DefOpt('guten_tag_hi_rust_implementation',
      \ ['Identifier', 'Function'])
call guten_tag#option#DefOpt('guten_tag_hi_rust_function',
      \ ['Identifier', 'Function'])
call guten_tag#option#DefOpt('guten_tag_hi_rust_enum',
      \ ['Identifier', 'Structure'])
call guten_tag#option#DefOpt('guten_tag_hi_rust_type',
      \ ['Identifier', 'Identifier'])
call guten_tag#option#DefOpt('guten_tag_hi_rust_global',
      \ ['Identifier', 'Label'])
call guten_tag#option#DefOpt('guten_tag_hi_rust_macro',
      \ ['Identifier', 'Function'])
call guten_tag#option#DefOpt('guten_tag_hi_rust_member',
      \ ['Identifier', 'Normal'])
call guten_tag#option#DefOpt('guten_tag_hi_rust_enum_member',
      \ ['Identifier', 'Normal'])
call guten_tag#option#DefOpt('guten_tag_hi_rust_method',
      \ ['Identifier', 'Function'])

let s:rust_highlight = {
      \ 'n': g:guten_tag_hi_rust_module,
      \ 's': g:guten_tag_hi_rust_struct,
      \ 'i': g:guten_tag_hi_rust_trait,
      \ 'c': g:guten_tag_hi_rust_implementation,
      \ 'f': g:guten_tag_hi_rust_function,
      \ 'g': g:guten_tag_hi_rust_enum,
      \ 't': g:guten_tag_hi_rust_type,
      \ 'v': g:guten_tag_hi_rust_global,
      \ 'M': g:guten_tag_hi_rust_macro,
      \ 'm': g:guten_tag_hi_rust_member,
      \ 'e': g:guten_tag_hi_rust_enum_member,
      \ 'P': g:guten_tag_hi_rust_method,
      \ }

" --- Scheme highlight --- "

call guten_tag#option#DefOpt('guten_tag_hi_scheme_function',
      \ ['Identifier', 'Function'])
call guten_tag#option#DefOpt('guten_tag_hi_scheme_set',
      \ ['Identifier', 'Identifier'])

let s:scheme_highlight = {
      \ 'f': g:guten_tag_hi_scheme_function,
      \ 's': g:guten_tag_hi_scheme_set,
      \ }

" --- Sh highlight --- "

call guten_tag#option#DefOpt('guten_tag_hi_sh_alias',
      \ ['Identifier', 'Identifier'])
call guten_tag#option#DefOpt('guten_tag_hi_sh_function',
      \ ['Identifier', 'Function'])
call guten_tag#option#DefOpt('guten_tag_hi_sh_script_file',
      \ ['Identifier', 'Label'])
call guten_tag#option#DefOpt('guten_tag_hi_sh_here_doc',
      \ ['Identifier', 'Title'])

let s:sh_highlight = {
      \ 'a': g:guten_tag_hi_sh_alias,
      \ 'f': g:guten_tag_hi_sh_function,
      \ 's': g:guten_tag_hi_sh_script_file,
      \ 'h': g:guten_tag_hi_sh_here_doc,
      \ }

" --- Vim highlight --- "

call guten_tag#option#DefOpt('guten_tag_hi_vim_autocommand',
      \ ['Identifier', 'Function'])
call guten_tag#option#DefOpt('guten_tag_hi_vim_command',
      \ ['Identifier', 'Statement'])
call guten_tag#option#DefOpt('guten_tag_hi_vim_function',
      \ ['Identifier', 'Function'])
call guten_tag#option#DefOpt('guten_tag_hi_vim_mapping',
      \ ['Identifier', 'Constant'])

let s:vim_highlight = {
      \ 'a': g:guten_tag_hi_vim_autocommand,
      \ 'c': g:guten_tag_hi_vim_command,
      \ 'f': g:guten_tag_hi_vim_function,
      \ 'm': g:guten_tag_hi_vim_mapping,
      \ }


" --- Tying this all together --- "

let s:highlight_groups = {
      \ 'C': s:c_highlight,
      \ 'C++': s:cpp_highlight,
      \ 'D': s:d_highlight,
      \ 'Go': s:go_highlight,
      \ 'Java': s:java_highlight,
      \ 'JavaScript': s:js_highlight,
      \ 'Lisp': s:lisp_highlight,
      \ 'Lua': s:lua_highlight,
      \ 'Perl': s:perl_highlight,
      \ 'Python': s:python_highlight,
      \ 'R': s:r_highlight,
      \ 'Ruby': s:ruby_highlight,
      \ 'Rust': s:rust_highlight,
      \ 'Scheme': s:scheme_highlight,
      \ 'Sh': s:sh_highlight,
      \ 'Vim': s:vim_highlight,
      \ }

" Set tag's highlighting settings based on its language and kind
function! guten_tag#highlight#SetHighlighting(tag)
  let l:kind = guten_tag#tag#TagKind(a:tag)
  if a:tag.fields.language ==# '' || l:kind ==# ''
    return
  endif
  if !has_key(s:highlight_groups, a:tag.fields.language)
    let a:tag.kind_highlight = 'Identifier'
    let a:tag.name_highlight = 'Normal'
    return
  endif
  let l:higroup = s:highlight_groups[a:tag.fields.language]
  if !has_key(l:higroup, l:kind)
    let a:tag.kind_highlight = 'Identifier'
    let a:tag.name_highlight = 'Normal'
    return
  endif
  let [a:tag.kind_highlight, a:tag.name_highlight] = l:higroup[l:kind]
endfunction
