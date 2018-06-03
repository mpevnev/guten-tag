" A file with IgnoreTag function used to weed out irrelevant tags
" Maintainer: Michail Pevnev <mpevnev@gmail.com>
" License: Vim's license

" --- Main thing --- "

function! guten_tag#ignore#IgnoreTag(tag)
  if !has_key(a:tag.fields, 'language')
    return 0
  endif
  let l:language = a:tag.fields.language
  if !has_key(s:ignore_mapping, l:language)
    return 0
  endif
  return s:ignore_mapping[l:language](a:tag)
endfunction

" --- Functions that do all the work --- "

function! s:IgnoreC(tag)
  let l:kind = guten_tag#tag#TagKind(a:tag)
  return l:kind =~# '\vh|l|z|L'
endfunction

function! s:IgnoreCPP(tag)
  let l:kind = guten_tag#tag#TagKind(a:tag)
  return l:kind =~# '\vh|l|v|z|L|A|N|U'
endfunction

function! s:IgnoreD(tag)
  let l:kind = guten_tag#tag#TagKind(a:tag)
  return l:kind =~# '\vl|V'
endfunction

function! s:IgnoreJava(tag)
  let l:kind = guten_tag#tag#TagKind(a:tag)
  return l:kind =~# '\vl|p'
endfunction

function! s:IgnorePerl(tag)
  let l:kind = guten_tag#tag#TagKind(a:tag)
  return l:kind ==# 'd'
endfunction

function! s:IgnorePython(tag)
  let l:kind = guten_tag#tag#TagKind(a:tag)
  return l:kind =~# '\vn|I|i|x|z|l'
endfunction

" --- Helpers --- "

let s:ignore_mapping = {
      \ 'C': function('s:IgnoreC'),
      \ 'C++': function('s:IgnoreCPP'),
      \ 'D': function('s:IgnoreD'),
      \ 'Java': function('s:IgnoreJava'),
      \ 'Perl': function('s:IgnorePerl'),
      \ 'Python': function('s:IgnorePython'),
      \ }
