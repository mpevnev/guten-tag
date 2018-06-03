" Functions used to build tags hierarchies
" Maintainer: Michail Pevnev <mpevnev@gmail.com>
" License: Vim's license

" --- Main things --- "

" Transform a flat list of tags into a dictionary where keys are file names
" and values are lists of tags appearing in this file.
function! guten_tag#hierarchy#Hierarchy(tags)
  let l:res = {}
  let l:separate = s:SeparateTagsByFilename(a:tags)
  for l:filename in keys(l:separate)
    let l:first_generation = []
    let l:previous_generation = []
    let l:candidates = []
    let l:tags_in_file = l:separate[l:filename]
    for l:tag in l:tags_in_file
      if guten_tag#container#CanHaveParent(l:tag)
        call add(l:candidates, l:tag) 
      else
        call add(l:first_generation, l:tag)
      endif
    endfor
    let l:previous_generation = l:first_generation
    while !empty(l:candidates)
      let l:new_candidates = []
      let l:new_generation = []
      for l:candidate in l:candidates
        let l:found_ancestor = 0
        for l:ancestor in l:previous_generation
          if guten_tag#container#Contains(l:ancestor, l:candidate)
            call add(l:ancestor.children, l:candidate)
            let l:candidate.parent = l:ancestor
            call add(l:new_generation, l:candidate)
            let l:found_ancestor = 1
            break
          endif
        endfor
        if !l:found_ancestor
          call add(l:new_candidates, l:candidate)
        endif
      endfor
      if l:previous_generation ==# l:new_generation
        " Add tags where parent could not be found as top-level tags
        let l:first_generation += l:new_generation
        break
      endif
      let l:previous_generation = l:new_generation
      let l:candidates = l:new_candidates
    endwhile
    let l:res[l:filename] = l:first_generation
  endfor
  return l:res
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
