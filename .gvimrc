set guifont=Consolas:h9
set encoding=utf-8
set vb t_vb=
set guioptions -=m "remove menu
set go-=L "remove left-hand side scroll

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

set wildchar=<Tab> wildmenu wildmode=full
set wildcharm=<C-Z>
nnoremap <F10> :b <C-Z>

" Intention/todo config
let $TODO_DIR='D:\notes\todo'
let $INTENTIONS_PATH=$TODO_DIR . '\intentions.txt'
