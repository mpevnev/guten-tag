" Functions used by the Guten Tag plugin
" Maintainer: Michail Pevnev <mpevnev@gmail.com>
" License: Vim's license

" --- Main things --- "

" Create a new window and populate it with a tag tree
function! guten_tag#CreateTagWindow()
  let l:files = tagfiles()
  if len(l:files) == 0
    return
  endif
  let l:file = l:files[0]
  let l:all_tags = s:ReadAllTags(l:file)
  let l:hierarchy = guten_tag#hierarchy#Hierarchy(l:all_tags)
  let l:buffer = guten_tag#buffer#Buffer(l:file, l:hierarchy)
  if bufexists(l:buffer.name)
    call s:ReopenTagWindow(l:buffer)
  else
    call s:OpenNewWindow(l:buffer)
  endif
endfunction

" Search up the directory tree until one of the file markers is found, and
" then uses this directory as a place to keep and look for tags file in.
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

" --- Helpers for tag option manipulation --- "

" Test if a file matches any of the forbidden locations.
function! s:ForbiddenLocations()
  let l:path = expand('%:p')
  for l:pattern in g:guten_tag_forbidden_paths
    if l:path =~# l:pattern
      return 1
    endif
  endfor
  return 0
endfunction

" Test if there is a marker in a given directory.
function! s:HasMarkers(dirpath)
  for l:marker in g:guten_tag_markers
    if !empty(globpath(a:dirpath, l:marker, 0, 1))
      return 1
    endif
  endfor
  return 0
endfunction

" --- Helpers for tag tree manipulations --- "

" Read all tags from a tag file
function! s:ReadAllTags(file)
  try
    let l:lines = readfile(a:file)
  catch /E484/
    return []
  endtry
  " Read all tags
  let l:all_tags = []
  for l:line in l:lines
    let l:new_tag = guten_tag#tag#Tag(l:line)
    if l:new_tag is# v:null
      continue
    endif
    if !guten_tag#tag#IgnoreTag(l:new_tag)
      call add(l:all_tags, l:new_tag)
    endif
  endfor
  return l:all_tags
endfunction

" Create and open a new window for a buffer
function! s:OpenNewWindow(buffer)
  if g:guten_tag_split_style ==# 'vertical'
    let l:command = g:guten_tag_window_width . 'vnew "' . a:buffer.name . '"'
  else
    let l:command = g:guten_tag_window_height . 'new "' . a:buffer.name . '"'
  endif
  exec l:command
  setlocal buftype=nofile
  setlocal nomodifiable
  exec 'file! ' . a:buffer.name
  call s:RefreshWindow(winnr(), a:buffer)
endfunction

" Reopen a closed window with a given buffer
function! s:ReopenTagWindow(buffer)
  let l:win = bufwinnr(a:buffer.name)
  if l:win <# 0
    call s:OpenNewWindow(a:buffer)
  else
    call s:RefreshWindow(l:win, a:buffer)
  endif
endfunction

" Reset window's contents
function! s:RefreshWindow(window, buffer)
  let l:content = guten_tag#buffer#BufferToText(a:buffer)
  exec a:window . 'wincmd w'
  setlocal modifiable
  normal! ggdG
  call append(0, l:content)
  setlocal nomodifiable
endfunction
