" Functions used by the Guten Tag plugin
" Last change: 19-May-2018
" Maintainer: Michail Pevnev <mpevnev@gmail.com>
" License: Vim's license

" --- Main functions --- "

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

" --- Helpers --- "

" Transform a flat list of tags into a list of top-level tags with children
function! s:BuildHierarchy(tags)
  let l:res = []
  " First, extract top-level tags
  for l:tag in a:tags
    let l:parent = s:GetParentName(l:tag)
    if l:parent is v:null
      call add(l:res, l:tag)
    endif
  endfor
  return l:res
endfunction

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

" Get the name of a tag's parent, return v:null if there isn't one.
function! s:GetParentName(tag)
  let l:fields = a:tag.fields
  let l:fields_to_test = ['struct', 'class']
  for l:fname in l:fields_to_test
    let l:res = get(l:fields, l:fname, v:null)
    if l:res isnot# v:null
      return l:res
    endif
  endfor
  return v:null
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

" Parse a tag file into a sequence of top-level tags
function! guten_tag#ParseFile(file)
  try
    let l:lines = readfile(a:file)
  catch /E484/
    return []
  endtry
  " Read all tags
  let l:all_tags = []
  for l:line in l:lines
    try
      let l:new_tag = s:ParseLine(l:line)
    catch /Comment line/
      continue
    endtry
    call add(l:all_tags, l:new_tag)
  endfor
  let l:all_tags = uniq(sort(l:all_tags))
  " Leave only top-level flags and place non-toplevel flags as children of
  " other flags
  return s:BuildHierarchy(l:all_tags)
endfunction

" Parse a tag file line into a dict.
function! s:ParseLine(line)
  if a:line =~# '\v^!.*'
    throw 'Comment line'
  endif
  let l:extract_name_and_file = split(a:line, "\t")
  let l:res = {}
  let l:res.name = l:extract_name_and_file[0]
  let l:res.filename = l:extract_name_and_file[1]
  let l:res.children = []
  let l:rest = join(l:extract_name_and_file[2:], "\t")
  " Remove the EX search command
  let l:extract_fields = split(l:rest, '"')
  if len(l:extract_fields) <= 1
    res.fields = {}
    return res
  endif
  " Just in case the fields contain a '"', join them back
  let l:extract_fields = join(l:extract_fields[1:], '"')
  let l:fields = {}
  for l:pair in split(l:extract_fields, "\t")
    let l:split = split(l:pair, ':')
    if len(l:split) == 1
      let l:key = 'kind'
      let l:value = l:split[0]
    else
      let l:key = l:split[0]
      let l:value = join(l:split[1:], ':')
    endif
    let l:fields[l:key] = l:value
  endfor
  let l:res.fields = l:fields
  return res
endfunction
