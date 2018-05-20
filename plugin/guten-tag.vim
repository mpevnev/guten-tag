" Vim plugin for exploring tag tree
" Last change: 19-May-2018
" Maintainer: Michail Pevnev <mpevnev@gmail.com>
" License: Vim's license

if &cp || exists('g:loaded_guten_tag')
  finish
endif
let g:loaded_guten_tag = 1

" Initialize the defaults
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

augroup PluginGutenTag
  autocmd!
  autocmd BufRead,BufNewFile * call guten_tag#SetTagsPath()
augroup END
