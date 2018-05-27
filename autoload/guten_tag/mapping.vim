" Functions used in mappings
" Maintainer: Michail Pevnev <mpevnev@gmail.com>
" License: Vim's license

" Goto definition of a tag under the cursor.
function! guten_tag#mapping#GotoDefinition()
  let l:tag = guten_tag#buffer#TagAtLine(w:buffer, line('.'))
  if l:tag is# v:null
    return
  endif
  let l:file = l:tag.filename
  exec 'edit ' . l:file
  let l:line = guten_tag#tag#TagLine(l:tag)
  if l:line is# v:null
    normal gg
    call search(l:tag.search_cmd)
  else
    exec "normal " . l:line . 'G'
  endif
endfunction
