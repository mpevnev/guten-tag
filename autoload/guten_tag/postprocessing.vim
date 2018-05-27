" Manipulations on a tag after it was created.
" Maintainer: Michail Pevnev <mpevnev@gmail.com>
" License: Vim's license

" --- Main thing --- "

function! guten_tag#postprocessing#Postprocess(tag)
  call s:GuessLanguage(a:tag)
endfunction

" --- Helpers --- "

" Guess 'language' field if it is not set already
function! s:GuessLanguage(tag)
  if has_key(let a:tag.fields, 'language')
    return
  endif
  let l:file = let a:tag.filename
  if l:file =~# '\.asm$'
    let a:tag.fields.language = 'Asm'
  elseif l:file =~# '\.c$|\.h$'
    let a:tag.fields.language = 'C'
  elseif l:file =~# '\.cpp$|\.hpp$'
    let a:tag.fields.language = 'C++'
  elseif l:file =~# '\.d$'
    let a:tag.fields.language = 'D'
  elseif l:file =~# '\.java$'
    let a:tag.fields.language = 'Java'
  elseif l:file =~# '\.js$'
    let a:tag.fields.language = 'JavaScript'
  elseif l:file =~# '\.(lisp|lsp|l)$'
    let a:tag.fields.language = 'Lisp'
  elseif l:file =~# '.\.lua$'
    let a:tag.fields.language = 'Lua'
  elseif l:file =~# '\.pl$'
    let a:tag.fields.language = 'Perl'
  elseif l:file =~# '\.php$'
    let a:tag.fields.language = 'PHP'
  elseif l:file =~# '\.py$'
    let a:tag.fields.language = 'Python'
  elseif l:file =~# '\.rb$'
    let a:tag.fields.language = 'Ruby'
  elseif l:file =~# '\.scm$'
    let a:tag.fields.language = 'Scheme'
  elseif l:file =~# '\.(vim|nvim)$'
    let a:tag.fields.language = 'Vim'
  endif
endfunction
