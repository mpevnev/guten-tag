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
  let l:res.shorten_path = g:guten_tag_shorten_path
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
  call s:SortTags(l:res.tags)
  return l:res
endfunction

" --- Presentation --- "

" Prepare a buffer for output - return a dict with text lines and fold info.
function! guten_tag#buffer#BufferRepr(buffer)
  let l:res = {}
  let l:res.text = []
  let l:res.folds = []
  let l:res.highlights = []
  let l:lastline = 1
  for l:file in a:buffer.files
    let l:file_repr = guten_tag#buffer#FileRepr(a:buffer, l:file)
    let l:res.text += l:file_repr.text
    let l:numlines = len(l:file_repr.text)
    for l:fold in l:file_repr.folds 
      call add(l:res.folds, [l:lastline + l:fold[0], l:lastline + l:fold[1]])
    endfor
    for l:highlight in l:file_repr.highlights
      let l:highlight.line += l:lastline - 1
      call add(l:res.highlights, l:highlight)
    endfor
    call add(l:res.folds, [l:lastline, l:lastline + l:numlines - 1])
    let l:lastline += l:numlines
  endfor
  return l:res
endfunction

" Prepare a file for output - return a dict with text lines and fold info.
function! guten_tag#buffer#FileRepr(buffer, file)
  let l:res = {}
  let l:res.folds = []
  let l:res.highlights = []
  let l:filename = fnamemodify(a:file.name, ':p')
  if a:buffer.shorten_path
    let l:filename = pathshorten(l:filename)
  endif
  let l:res.text = [l:filename]
  if len(a:file.tags) ==# 0
    return l:res
  endif
  let l:line = 1
  for l:toplevel in a:file.tags
    let l:indent = g:guten_tag_indent
    let l:traversals = [s:MakeTraversal(l:toplevel, l:line)]
    call s:AddHighlight(l:res.highlights, l:toplevel, l:line, l:indent)
    let l:line += s:AddLine(a:buffer, l:res.text, l:toplevel, l:indent, 1)
    let l:indent += g:guten_tag_indent
    while len(l:traversals) ># 0
      let l:cur_trav = l:traversals[-1]
      if l:cur_trav.child_index ==# len(l:cur_trav.parent.children)
        unlet l:traversals[-1]
        let l:indent -= g:guten_tag_indent
        if len(l:cur_trav.parent.children) !=# 0
          call add(l:res.folds, [l:cur_trav.foldstart, l:line - 1])
        endif
        continue
      endif
      let l:cur = l:cur_trav.parent.children[l:cur_trav.child_index]
      call s:AddHighlight(l:res.highlights, l:cur, l:line, l:indent)
      let l:line += s:AddLine(a:buffer, l:res.text, l:cur, l:indent, 0)
      if len(l:cur.children) ># 0
        call add(l:traversals, s:MakeTraversal(l:cur, l:line + 1))
        continue
      endif
      let l:cur_trav.child_index += 1
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

" Add a highlight to a highlight list
function! s:AddHighlight(group, tag, line, indent)
  if has('nvim')
    call add(a:group, s:MakeHighlight(a:tag, a:line, a:indent))
  endif
endfunction

" Add a line for a given tag, maybe followed by an empty line if 'dense' is
" not set. Return the number of lines added.
function! s:AddLine(buffer, add_to, tag, indent_level, print_parent)
  call add(a:add_to, s:MakeLine(a:tag, a:indent_level))
  if !a:buffer.dense
    call add(a:add_to, "")
    return 2
  endif
  return 1
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

" Create a dict with highlight info
function! s:MakeHighlight(tag, line, indent)
  let l:res = {}
  let l:res.line = a:line
  let l:res.kind = a:tag.kind_highlight
  let l:res.kind_col = a:indent
  let l:res.name = a:tag.name_highlight
  let l:res.name_col = a:indent + 2
  let l:res.name_len = strlen(a:tag.name)
  return l:res
endfunction

" Create a line from a tag
function! s:MakeLine(tag, indent_level)
  let l:kind = guten_tag#tag#TagKind(a:tag)
  let l:new_line = l:kind ==# '' ? '' : l:kind . ' '
  let l:new_line = l:new_line . a:tag.name
  return repeat(' ', a:indent_level) . l:new_line
endfunction

" Create a dict with file traversal information.
function! s:MakeTraversal(parent, foldstart)
  let l:res = {}
  let l:res.parent = a:parent
  let l:res.child_index = 0
  let l:res.foldstart = a:foldstart
  return l:res
endfunction

" Sort tags list, recursively
function! s:SortTags(tags)
  call sort(a:tags, function('guten_tag#tag#Compare'))
  for l:tag in a:tags
    call s:SortTags(l:tag.children)
  endfor
endfunction
