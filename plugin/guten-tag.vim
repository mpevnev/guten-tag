" Vim plugin for exploring tag tree and managing tags
" Maintainer: Michail Pevnev <mpevnev@gmail.com>
" License: Vim's license


if &cp || exists('g:loaded_guten_tag')
  finish
endif
let g:loaded_guten_tag = 1

" Initialize the defaults - tag management
call guten_tag#option#DefOpt('guten_tag_forbidden_paths',
      \ ['\v^/usr/.*', '\v^/etc/.*', '\v/var/.*'])
call guten_tag#option#DefOpt('guten_tag_markers',
      \ ['.git', 'src', 'source'])
call guten_tag#option#DefOpt('guten_tag_tags_files',
      \ ['tags', 'TAGS'])
call guten_tag#option#DefOpt('guten_tag_tags_when_forbidden', &tags)

" Initialize the defaults - tags exploration
call guten_tag#option#DefOpt('guten_tag_dense', 0)
call guten_tag#option#DefOpt('guten_tag_indent', 2)
call guten_tag#option#DefOpt('guten_tag_split_style', 'vertical')
call guten_tag#option#DefOpt('guten_tag_window_height', 30)
call guten_tag#option#DefOpt('guten_tag_window_width', 35)

augroup PluginGutenTag
  autocmd!
  autocmd BufRead,BufNewFile * call guten_tag#SetTagsPath()
augroup END

" Commands
command! GutenTagOpenTagWindow call guten_tag#CreateTagWindow()
