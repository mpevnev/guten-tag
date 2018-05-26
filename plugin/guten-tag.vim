" Vim plugin for exploring tag tree and managing tags
" Maintainer: Michail Pevnev <mpevnev@gmail.com>
" License: Vim's license


if &cp || exists('g:loaded_guten_tag')
  finish
endif
let g:loaded_guten_tag = 1

" Initialize the defaults - tag management
call guten_tag#Setopt('guten_tag_forbidden_paths',
      \ ['\v^/usr/.*', '\v^/etc/.*', '\v/var/.*'], v:null)
call guten_tag#Setopt('guten_tag_markers',
      \ ['.git', 'src', 'source'], v:null)
call guten_tag#Setopt('guten_tag_tags_files',
      \ ['tags', 'TAGS'], v:null)
call guten_tag#Setopt('guten_tag_tags_when_forbidden',
      \ &tags, v:null)

" Initialize the defaults - tags exploration
call guten_tag#Setopt('guten_tag_dense', 0, v:null)
call guten_tag#Setopt('guten_tag_indent', 2, v:null)
call guten_tag#Setopt('guten_tag_split_style', 'vertical', v:null)
call guten_tag#Setopt('guten_tag_window_height', 30, v:null)
call guten_tag#Setopt('guten_tag_window_width', 35, v:null)

augroup PluginGutenTag
  autocmd!
  autocmd BufRead,BufNewFile * call guten_tag#SetTagsPath()
augroup END

" Commands
command! GutenTagOpenTagWindow call guten_tag#CreateTagWindow()
