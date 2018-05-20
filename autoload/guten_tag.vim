" Functions used by the Guten Tag plugin
" Last change: 19-May-2018
" Maintainer: Michail Pevnev <mpevnev@gmail.com>
" License: Vim's license

" --- Main function --- "

" This function searches up the directory tree until one of the file markers
" is found, and then uses this directory as a place to keep and look for tags
" file in.
function! guten_tag#SetTagsPath()
  " First check if we're in an directory or a file which is forbidden from
  " having local tags files.
  let l:path = expand('%:p')
  if s:ForbiddenLocations()
    let &l:tags = g:guten_tag_tags_when_forbidden
    return
  endif
  " Find a marker
  while 1
    let l:path = fnamemodify(l:path, ':h')
    if s:HasMarkers(l:path)
      break
    endif
    if l:path ==# '/'
      return
    endif
  endwhile
  " Make a tags option
  let l:toplevel_tags = []
  for l:tagfile in g:guten_tag_tags_files
    call add(l:toplevel_tags, l:path . '/' . l:tagfile)
  endfor
  let &l:tags = join(l:toplevel_tags, ',')
endfunction

" --- Helpers --- "

" This function tests if a file matches any of the forbidden locations.
function! s:ForbiddenLocations()
  let l:path = expand('%:p')
  for l:pattern in g:guten_tag_forbidden_paths
    if l:path =~# l:pattern
      return 1
    endif
  endfor
  return 0
endfunction

" This function tests if there is a marker in a given directory
function! s:HasMarkers(dirpath)
  for l:marker in g:guten_tag_markers
    if !empty(globpath(a:dirpath, l:marker, 0, 1))
      return 1
    endif
  endfor
  return 0
endfunction
