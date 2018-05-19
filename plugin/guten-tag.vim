" Vim plugin for exploring tag tree
" Last change: 19-May-2018
" Maintainer: Michail Pevnev <mpevnev@gmail.com>
" License: Vim's license

if &cp || exists('g:loaded_guten_tag')
  finish
end
let g:loaded_guten_tag = 1

augroup PluginGutenTag
  autocmd BufReadPost * call guten_tag#test()
augroup END
