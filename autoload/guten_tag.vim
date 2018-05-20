" Functions used by the Guten Tag plugin
" Last change: 19-May-2018
" Maintainer: Michail Pevnev <mpevnev@gmail.com>
" License: Vim's license

" This function searches up the directory tree until one of the file markers
" is found, and then uses this directory as a place to keep and look for tags
" file in.
function! guten_tag#SetTagsPath()
  " First check if we're in an directory or a file which is forbidden from
  " having local tags files.
  let l:path = expand('%:p')
  if guten_tag#ForbiddenLocals()
    let &l:tags = g:guten_tag_tags_when_forbidden
    return
  endif
  let l:go_on = v:true
  let l:detected_head_directory = v:false
  " Find a marker
  while l:go_on
    let l:path = fnamemodify(l:path, ':h')
    for l:marker in g:guten_tag_markers
      if !empty(glob(l:path . '/' . l:marker))
        let l:go_on = v:false
        let l:detected_head_directory = v:true
      endif
    endfor
    if l:path ==# '/'
      return
    endif
  endwhile
  if !l:detected_head_directory
    return
  endif
  " Make a tags option
  let l:toplevel_tags = []
  for l:tag in g:guten_tag_tags_files
    call add(l:toplevel_tags, l:path . '/' . l:tag)
  endfor
  let &l:tags = join(l:toplevel_tags + [&l:tags] + [&tags], ',')
endfunction

" This function tests if a file matches any of the forbidden locations.
function! guten_tag#ForbiddenLocals()
  let l:path = expand('%:p')
  for l:pattern in g:guten_tag_forbidden_paths
    if l:path =~# l:pattern
      return 1
    endif
  endfor
  return 0
endfunction
