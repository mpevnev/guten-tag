" Vim plugin for exploring tag tree and managing tags
" Maintainer: Michail Pevnev <mpevnev@gmail.com>
" License: Vim's license


if &cp || exists('g:loaded_guten_tag')
  finish
endif
let g:loaded_guten_tag = 1

" Initialize the defaults - tag management
if !exists('g:guten_tag_forbidden_paths')
  let g:guten_tag_forbidden_paths = ['\v^/usr/.*', '\v^/etc/.*', '\v/var/.*']
endif
if !exists('g:guten_tag_markers')
  let g:guten_tag_markers = ['.git', 'src', 'source']
endif
if !exists('g:guten_tag_tags_files')
  let g:guten_tag_tags_files = ['tags', 'TAGS']
endif
if !exists('g:guten_tag_tags_when_forbidden')
  let g:guten_tag_tags_when_forbidden = &tags
endif

" Initialize the defaults - tags exploration
if !exists('g:guten_tag_indent')
  let g:guten_tag_indent = 2
endif
if !exists('g:guten_tag_split_style')
  let g:gute_tag_split_style = 'vertical'
endif
if !exists('g:guten_tag_window_height')
  let g:guten_tag_window_height = 20
endif
if !exists('g:gute_tag_window_width')
  let g:guten_tag_window_width = 25
endif

augroup PluginGutenTag
  autocmd!
  autocmd BufRead,BufNewFile * call guten_tag#SetTagsPath()
augroup END
