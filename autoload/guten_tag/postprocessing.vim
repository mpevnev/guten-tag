" Manipulations on a tag after it was created.
" Maintainer: Michail Pevnev <mpevnev@gmail.com>
" License: Vim's license

" --- Main thing --- "

function! guten_tag#postprocessing#Postprocess(tag)
  call s:GuessLanguage(a:tag)
  call s:SetHighlighting(a:tag)
endfunction

" --- Language autodetection --- "

" Guess 'language' field if it is not set already.
function! s:GuessLanguage(tag)
  if has_key(a:tag.fields, 'language')
    return
  endif
  let l:file = a:tag.filename
  if l:file =~# '\v\.asm$'
    let a:tag.fields.language = 'Asm'
  elseif l:file =~# '\v\.c$|\.h$'
    let a:tag.fields.language = 'C'
  elseif l:file =~# '\v\.cpp$|\.hpp$'
    let a:tag.fields.language = 'C++'
  elseif l:file =~# '\v\.d$'
    let a:tag.fields.language = 'D'
  elseif l:file =~# '\v\.go$'
    let a:tag.fields.language = 'Go'
  elseif l:file =~# '\v\.java$'
    let a:tag.fields.language = 'Java'
  elseif l:file =~# '\v\.js$'
    let a:tag.fields.language = 'JavaScript'
  elseif l:file =~# '\v\.(lisp|lsp|l)$'
    let a:tag.fields.language = 'Lisp'
  elseif l:file =~# '\v\.lua$'
    let a:tag.fields.language = 'Lua'
  elseif l:file =~# '\v\.pl$'
    let a:tag.fields.language = 'Perl'
  elseif l:file =~# '\v\.php$'
    let a:tag.fields.language = 'PHP'
  elseif l:file =~# '\v\.py$'
    let a:tag.fields.language = 'Python'
  elseif l:file =~# '\v\.(r|R)$'
    let a:tag.fields.language = 'R'
  elseif l:file =~# '\v\.rb$'
    let a:tag.fields.language = 'Ruby'
  elseif l:file =~# '\v\.scm$'
    let a:tag.fields.language = 'Scheme'
  elseif l:file =~# '\v\.(vim|nvim)$'
    let a:tag.fields.language = 'Vim'
  else
    let a:tag.fields.language = ''
  endif
endfunction

" --- Highlighting --- "

" Set highlighting fields for a tag based on its language and kind.
function! s:SetHighlighting(tag)
  if !has('nvim')
    return
  endif
  call guten_tag#highlight#SetHighlighting(a:tag)
endfunction
