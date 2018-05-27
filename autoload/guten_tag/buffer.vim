" Buffer-manipulating functions and structures
" Maintainer: Michail Pevnev <mpevnev@gmail.com>
" License: Vim's license

" --- Structures --- "

" Create a buffer object
function! guten_tag#buffer#Buffer(tags_file, hierarchy)
  let l:res = {}
  let l:res.name = s:MakeBufferName(a:tags_file)
  let l:res.tags_file = a:tags_file
  let l:res.dense = g:guten_tag_dense
  let l:res.files = []
  for l:filename in sort(keys(a:hierarchy))
    let l:file = guten_tag#buffer#File(l:filename, a:hierarchy[l:filename])
    call add(l:res.files, l:file)
  endfor
  return l:res
endfunction

" Create a file object - think a folder with other tags
function! guten_tag#buffer#File(filename, tags)
  let l:res = {}
  let l:res.name = a:filename
  let l:res.tags = a:tags
  call sort(l:res.tags, function('guten_tag#tag#Compare'))
  return l:res
endfunction

" --- Presentation --- "

" Convert a buffer object to its textual representation (a list of lines)
function! guten_tag#buffer#BufferToText(buffer)
  let l:res = []
  for l:file in a:buffer.files
    let l:res += guten_tag#buffer#FileToText(a:buffer, l:file)
  endfor
  return l:res
endfunction

" Convert a file object to its textual representation (a list of lines)
function! guten_tag#buffer#FileToText(buffer, file)
  let l:res = [fnamemodify(a:file.name, ':p')]
  if len(a:file.tags) ==# 0
    return l:res
  endif
  for l:toplevel in a:file.tags
    let l:indent = g:guten_tag_indent
    call s:AddLine(a:buffer, l:res, l:toplevel, l:indent, 1)
    let l:traversal = [[l:toplevel, 0]] " tag, current child index
    let l:indent += g:guten_tag_indent
    while len(l:traversal) ># 0
      let [l:parent, l:child_index] = l:traversal[-1]
      if l:child_index ==# len(l:parent.children)
        unlet l:traversal[-1]
        let l:indent -= g:guten_tag_indent
        continue
      endif
      let l:cur = l:parent.children[l:child_index]
      call s:AddLine(a:buffer, l:res, l:cur, l:indent, 0)
      if len(l:cur.children) ># 0
        call add(l:traversal, [l:cur, 0])
        continue
      endif
      let l:traversal[-1][1] += 1
    endwhile
  endfor
  return l:res
endfunction

" --- tag lookup --- "

" Return a tag at a given line in a buffer, or v:null if there's nothing at
" this line.
function! guten_tag#buffer#TagAtLine(buffer, line)
  let l:filestart = 1
  for l:file in a:buffer.files
    if a:line ==# l:filestart
      return v:null
    endif
    let l:tags = s:AllTags(l:file)
    let l:numtags = len(l:tags)
    if a:buffer.dense
      if a:line ># l:filestart + l:numtags
        let l:filestart += l:numtags + 1
        continue
      endif
      return l:tags[a:line - l:filestart - 1]
    else
      if a:line ># l:filestart + l:numtags * 2
        let l:filestart += l:numtags * 2 + 1
        continue
      endif
      let l:index = a:line - l:filestart - 1
      if l:index % 2 ==# 1
        return v:null
      endif
      return l:tags[l:index / 2]
    endif
  endfor
  return v:null
endfunction

" --- Helpers --- "

" Add a line for a given tag, maybe followed by an empty line if 'dense' is
" not set
function! s:AddLine(buffer, add_to, tag, indent_level, print_parent)
  call add(a:add_to, s:MakeLine(a:tag, a:indent_level, a:print_parent))
  if !a:buffer.dense
    call add(a:add_to, "")
  endif
endfunction

" Return a flat list of all tags in a file
function! s:AllTags(file)
  let l:res = []
  for l:toplevel in a:file.tags
    call add(l:res, l:toplevel)
    let l:traversal = [[l:toplevel, 0]] " tag, current child index
    while len(l:traversal) ># 0
      let [l:parent, l:child_index] = l:traversal[-1]
      if l:child_index ==# len(l:parent.children)
        unlet l:traversal[-1]
        continue
      endif
      let l:cur = l:parent.children[l:child_index]
      call add(l:res, l:cur)
      if len(l:cur.children) ># 0
        call add(l:traversal, [l:cur, 0])
        continue
      endif
      let l:traversal[-1][1] += 1
    endwhile
  endfor
  return l:res
endfunction

" Generate a name for tag exploration buffer
function! s:MakeBufferName(tags_file)
  return 'Guten Tag, ' . fnamemodify(a:tags_file, ':p')
endfunction

" Create a line from a tag
function! s:MakeLine(tag, indent_level, print_parent)
  let l:kind = guten_tag#tag#TagKind(a:tag)
  let l:new_line = l:kind ==# '' ? '' : l:kind . ' '
  let l:new_line = l:new_line . a:tag.name
  if a:print_parent
    let l:parent = guten_tag#tag#TagParentName(a:tag)
    if l:parent isnot# v:null
      let l:new_line = l:new_line . ' (owned by ' . (l:parent) . ')'
    endif
  endif
  return repeat(' ', a:indent_level) . l:new_line
endfunction
