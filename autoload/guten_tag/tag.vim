" Tag-manipulating functions
" Maintainer: Michail Pevnev <mpevnev@gmail.com>
" License: Vim's license

" Create and return a tag from a line, or v:null if the line is a comment
function! guten_tag#tag#Tag(line)
  if a:line =~# '\v^!.*'
    return v:null
  endif
  let l:extract_name_and_file = split(a:line, "\t")
  let l:res = {}
  let l:res.name = l:extract_name_and_file[0]
  let l:res.filename = l:extract_name_and_file[1]
  let l:res.children = []
  let l:rest = join(l:extract_name_and_file[2:], "\t")
  " Extract EX search command
  let l:extract_fields = split(l:rest, '"')
  if len(l:extract_fields) <= 1
    res.fields = {}
    call s:TagPostprocessing(l:res)
    return res
  endif
  let l:res.search_cmd = l:extract_fields[0]
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
  call guten_tag#postprocessing#Postprocess(l:res)
  return res
endfunction

" Return the first tag with a given name from a list, or null if there's no
" such tag
function! guten_tag#tag#TagByName(name, list)
  for l:tag in a:list
    if l:tag.name ==# a:name
      return l:tag
    endif
  endfor
  return v:null
endfunction

" Get the first letter of 'kind' attribute
function! guten_tag#tag#TagKind(tag)
  if has_key(a:tag.fields, 'kind')
    let l:kind = a:tag.fields.kind
  else
    return ""
  endif
  if l:kind ==# ""
    return ""
  else
    return strcharpart(l:kind, 0, 1)
  endif
endfunction

" Get the name of a tag's parent, return v:null if there isn't one.
function! guten_tag#tag#TagParentName(tag)
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

" Return a line where the tag is located, or -1 if this information is
" unavailable.
function! guten_tag#tag#TagLine(tag)
  return get(a:tag.fields, 'line', -1)
endfunction
