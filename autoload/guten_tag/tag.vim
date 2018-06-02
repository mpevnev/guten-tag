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
  let l:res.parent = v:null
  let l:res.children = []
  let l:res.kind_highlight = ""
  let l:res.name_highlight = ""
  let l:rest = l:extract_name_and_file[2:]
  " Extract EX search command
  if len(l:res) ==# 0
    let l:res.search_cmd = v:null
    let l:res.fields = {}
    call guten_tag#postprocessing#Postprocess(l:res)
    return l:res
  endif
  let l:search_blocks = 0
  while l:search_blocks <# len(l:rest)
    let l:block = l:rest[l:search_blocks]
    let l:search_blocks += 1
    if l:block =~# ';"'
      break
    endif
  endwhile
  let l:search = join(l:rest[0 : l:search_blocks - 1], "\t")
  let l:res.search_cmd = strcharpart(l:search, 1, len(l:search) - 4)
  " Extract the fields
  let l:extract_fields = l:rest[l:search_blocks:]
  if len(l:extract_fields) ==# 0
    let l:res.fields = {}
    call guten_tag#postprocessing#Postprocess(l:res)
    return l:res
  endif
  let l:fields = {}
  for l:pair in l:extract_fields
    if l:pair =~# '\v.*:$'
      let l:no_value = 1
    else
      let l:no_value = 0
    endif
    let l:split = split(l:pair, ':')
    if len(l:split) == 1
      if l:no_value
        let l:key = l:split[0]
        let l:value = ""
      else
        let l:key = 'kind'
        let l:value = l:split[0]
      endif
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

" Compare two tags
function! guten_tag#tag#Compare(a, b)
  let l:kind_a = guten_tag#tag#TagKind(a:a)
  let l:kind_b = guten_tag#tag#TagKind(a:b)
  if l:kind_a <# l:kind_b
    return -1
  elseif l:kind_a ># l:kind_b
    return 1
  endif
  if a:a.name <# a:b.name
    return -1
  elseif a:a.name ># a:b.name
    return 1
  else
    return 0
  endif
endfunction

" Get the first letter of 'kind' attribute
function! guten_tag#tag#TagKind(tag)
  return strcharpart(get(a:tag.fields, 'kind', ''), 0, 1)
endfunction

" Return a line where the tag is located, or -1 if this information is
" unavailable.
function! guten_tag#tag#TagLine(tag)
  return get(a:tag.fields, 'line', -1)
endfunction
