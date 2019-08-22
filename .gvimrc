"set guifont=Liberation_Mono_for_Powerline:h10 
"set guifont=Roboto_Mono_for_Powerline:h10 
"set guifont=Ubuntu_Mono_derivative_Powerline:h20
set guifont=Consolas:h9
set encoding=utf-8
set vb t_vb=
set guioptions -=m 

" Need to override env variable used in .vimrc
let $TODODIR="D:\\notes\\todo"
if has("windows")
    "set shell=C:\Windows\Sysnative\wsl.exe
    "set shellpipe=|
    "set shellredir=>
    "set shellcmdflag=
    "set noshelltemp
endif

" Use system copy/paste buffer
set clipboard=unnamed

map <F11> <Esc>:call ToggleFullscreen()<CR>
map <F9> <Esc>:call ToggleWritingMode()<CR>

function! ToggleWritingMode()
    if g:fullscreen
        :set go+=r
    else
        :set go-=r
    endif
    :call ToggleFullscreen()
    :Goyo
endfunction

let g:fullscreen = 0
function! ToggleFullscreen()
    :let g:fullscreen = !g:fullscreen
    :call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)
endfunction
