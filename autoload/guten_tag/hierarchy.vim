" Functions used to build tags hierarchies
" Maintainer: Michail Pevnev <mpevnev@gmail.com>
" License: Vim's license

" --- Main things --- "

" Transform a flat list of tags into a dictionary where keys are file names
" and values are lists of tags appearing in this file.
function! guten_tag#hierarchy#Hierarchy(tags)
  let l:res = []
  " First, extract top-level tags
  for l:tag in a:tags
    let l:parent = guten_tag#tag#TagParentName(l:tag)
    if l:parent is# v:null
      call add(l:res, l:tag)
    endif
  endfor
  " Now, attach non-top-level tags to them
  for l:tags_in_file in values(s:SeparateTagsByFilename(a:tags))
    for l:tag in l:tags_in_file
      let l:parent_name = guten_tag#tag#TagParentName(l:tag)
      if l:parent_name is# v:null
        continue
      endif
      let l:parent = guten_tag#tag#TagByName(l:tag, l:parent_name, l:tags_in_file)
      if l:parent is# v:null
        " If it's not possible to determine tag's parent, treat it as a top
        " level tag.
        call add(l:res, l:tag)
      else
        call add(l:parent.children, l:tag)
      endif
    endfor
  endfor
  return s:SeparateTagsByFilename(l:res)
endfunction

" --- Helpers --- "

" Return a dict where keys are filenames and values are lists of tags
" appearing in the corresponding file
function! s:SeparateTagsByFilename(tags)
  let l:res = {}
  for l:tag in a:tags
    let l:file = l:tag.filename
    if has_key(l:res, l:file)
      call add(l:res[l:file], l:tag)
    else
      let l:res[l:file] = [l:tag]
    endif
  endfor
  return l:res
endfunction
