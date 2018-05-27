" Functions used in mappings
" Maintainer: Michail Pevnev <mpevnev@gmail.com>
" License: Vim's license

" Goto definition of a tag under the cursor.
function! guten_tag#mapping#GotoDefinition() abort
  let l:tag = guten_tag#buffer#TagAtLine(b:buffer, line('.'))
  if l:tag is# v:null
    return
  endif
  let l:file = l:tag.filename
  if g:guten_tag_goto_split_style ==# 'horizontal'
    let l:command = 'split ' . l:file
  elseif g:guten_tag_goto_split_style ==# 'vertical'
    let l:command = 'vsplit ' . l:file
  else
    throw 'GutenTag: unknown split style "' . g:guten_tag_goto_split_style . '"'
  endif
  if g:guten_tag_goto_position ==# 'topleft'
    let l:command = 'topleft ' . l:command
  elseif g:guten_tag_goto_position ==# 'botright'
    let l:command = 'botright ' . l:command
  elseif g:guten_tag_goto_position ==# 'aboveleft'
    let l:command = 'aboveleft ' . l:command
  elseif g:guten_tag_goto_position ==# 'belowright'
    let l:command = 'belowright ' . l:command
  else
    throw 'GutenTag: unknown position option "' . g:guten_tag_goto_position . '"'
  endif
  exec l:command
  let l:line = guten_tag#tag#TagLine(l:tag)
  if l:line <# 0
    normal gg
    call search(l:tag.search_cmd, 'cw')
  else
    exec "normal " . l:line . 'G'
  endif
endfunction
