" autoload/utils/fs.vim - contains function to work with the file system
" Maintainer:   Ilya Churaev <https://github.com/ilyachur>

" Create directory
function! utils#fs#makeDir(dir) abort
    let l:directory = finddir(a:dir, getcwd().';.')
    if l:directory ==# ''
        silent call mkdir(a:dir, 'p')
        let l:directory = finddir(a:dir, getcwd().';.')
    endif
    if l:directory ==# ''
        echohl WarningMsg |
                    \ echomsg 'Cannot create a build directory: '.a:dir |
                    \ echohl None
        return
    endif
    return l:directory
endfunction

" Remove directory
function! utils#fs#removeDirectory(file) abort
    if has('win32')
        silent call system("rd /S /Q \"".a:file."\"")
    else
        silent call system("rm -rf '".a:file."'")
    endif
endfunction

" Remove file
function! utils#fs#removeFile(file) abort
    if has('win32')
        silent call system("del /F /Q \"".a:file."\"")
    else
        silent call system("rm -rf '".a:file."'")
    endif
endfunction

" Create a link
function! utils#fs#createLink(src, dst) abort
    " Need to wait for end of Dispatch Make
    " if !filereadable(a:src)
    "     return
    " endif
    silent call utils#fs#removeFile(a:dst)
    if has('win32')
        silent call system('copy ' . a:src . ' ' . a:dst)
    else
        silent call system('ln -s ' . a:src . ' ' . a:dst)
    endif
endfunction
