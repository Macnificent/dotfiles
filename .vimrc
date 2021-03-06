"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer:
"       Amir Salihefendic — @amix3k
"
" Awesome_version:
"       Get this config, nice color schemes and lots of plugins!
"
"       Install the awesome version from:
"
"           https://github.com/amix/vimrc
"
" Sections:
"    -> General
"    -> VIM user interface
"    -> Colors and Fonts
"    -> Files and backups
"    -> Text, tab and indent related
"    -> Visual mode related
"    -> Moving around, tabs and buffers
"    -> Status line
"    -> Editing mappings
"    -> vimgrep searching and cope displaying
"    -> Spell checking
"    -> Misc
"    -> Helper functions
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    execute pathogen#infect()
"if !has("gui_running")
"endif

" Disable bells
set vb
set t_vb=

" Sets how many lines of history VIM has to remember
set history=500

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>

" :W sudo saves the file
" (useful for handling the permission-denied error)
command! W w !sudo tee % > /dev/null


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Avoid garbled characters in Chinese language windows OS
let $LANG='en'
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" Turn on the Wild menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

"Always show current position
set ruler

" Height of the command bar
set cmdheight=1

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
"set noerrorbells
"set novisualbell
"set t_vb=
"set tm=500
"
" Properly disable sound on errors on MacVim
if has("gui_macvim")
    autocmd GUIEnter * set vb t_vb=
endif


" Add a bit extra margin to the left
set foldcolumn=1


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" => Colors and Fonts
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Enable syntax highlighting
syntax enable


set background=dark
colorscheme flattened_light

" Enable 256 colors palette in Gnome Terminal
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif


" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" => Files, backups and undo
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines


""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
map <c-space> ?

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :Bclose<cr>:tabclose<cr>gT

" Close all the buffers
map <leader>ba :bufdo bd<cr>

map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>t<leader> :tabnext

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()


" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


""""""""""""""""""""""""""""""
"" => Status line
"""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
"set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" => Editing mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
map 0 ^

" Move one or more lines of text using Ctrl+j and Ctrl+k
nmap <C-j> mz:m+<cr>`z
nmap <C-k> mz:m-2<cr>`z
vmap <C-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <C-k> :m'<-2<cr>`>my`<mzgv`yo`z

if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" => Spell checking
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" => Misc
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Quickly open a buffer for scribble
map <leader>q :e ~/buffer<cr>

" Quickly open a markdown buffer for scribble
map <leader>x :e ~/buffer.md<cr>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" => Helper functions
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction

function! CmdLine(str)
    call feedkeys(":" . a:str)
endfunction

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" AltGr+k to exit insert mode
imap ĸ <Esc>

" AltGr+k to enter insert mode
nmap ĸ i

" Temporarily disable arrow keys (to re-train muscle memory)
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>

" Type ,c<Enter> after search to show number of matches
nmap ,c :%s///gn

" Remove delay when switching to/from insert mode
set timeoutlen=1000 ttimeoutlen=0

" Clear highlighting on escape in normal mode
" nnoremap <esc> :noh<return><esc>
nnoremap <esc> :let @/ = ""<cr>
" nnoremap <esc>^[ <esc>^[

" Show line numbers
set number
"set relativenumber

" Remove vertical line in pane separator
set fillchars+=vert:\

" nerdtree.vim
" Go to previous (last accessed) window.
autocmd VimEnter * wincmd p
" Close vim if NerdTree is the last open window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
noremap <silent>ö :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

" Airline
if !exists('g:airline_symbols')
let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'
"let g:airline_powerline_fonts = 1
"let g:airline_theme = 'gruvbox'
"let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#show_buffers = 0
"let g:airline#extensions#tabline#show_splits = 0
"let g:airline#extensions#tabline#show_tabs = 1
"let g:airline#extensions#tabline#show_tab_nr = 0
"let g:airline#extensions#tabline#show_tab_type = 0
"let g:airline#extensions#tabline#close_symbol = '×'
"let g:airline#extensions#tabline#show_close_button = 0

" Improve paren highlighting (https://stackoverflow.com/a/10746829)
hi MatchParen cterm=bold ctermbg=none ctermfg=magenta

" WSL yank support
let s:clip = '/mnt/c/Windows/System32/clip.exe'  " default location
if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * call system(s:clip, join(v:event.regcontents, "\<CR>"))
    augroup END
end

" I'm mostly editing plain-text, so this is pretty useful for note-taking etc
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=2

" Edit vimr configuration file
nnoremap <Leader>ve :e $MYVIMRC<CR><Esc>
" " Reload vimr configuration file
nnoremap <Leader>vr :source $MYVIMRC<CR><Esc>

" https://stackoverflow.com/a/6271254
function! GetVisualSelection()
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)
    if len(lines) == 0
        return ''
    endif
    let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][column_start - 1:]
    return join(lines, "\n")
endfunction

" Simpler tab navigation
nnoremap <C-n> :tabprevious<CR>
nnoremap <C-m> :tabnext<CR>

" Add new line without entering insert mode
nmap <S-Enter> O<Esc>
nmap <C-Enter> o<Esc>

function! Insert(text)
    " a simple function to insert text where the cursor is
    execute "normal! \<Esc>a".a:text
endfunction

function! Strip(text)
    return substitute(a:text, '^\_s*\(.\{-}\)\_s*$', '\1', '')
endfunction

" =======================
" Goyo + Limelight config
" =======================

function! s:goyo_enter()
  silent !tmux set status off
  silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  set noshowmode
  set noshowcmd
  set scrolloff=999
  "Limelight

  let b:quitting = 0
  let b:quitting_bang = 0
  autocmd QuitPre <buffer> let b:quitting = 1
  cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!

endfunction

function! s:goyo_leave()
  silent !tmux set status on
  silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  set showmode
  set showcmd
  set scrolloff=5
  "Limelight!

    " Quit Vim if this is the only remaining buffer
  if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
    if b:quitting_bang
      qa!
    else
      qa
    endif
  endif

endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240
let g:goyo_height = '100%'
let g:goyo_width = '70%'

" ========================================================
" Mappings and functions to simplify note-taking and todos
" ========================================================

command! Nextday :call InsertNextDay()
map <Leader>nd :call InsertNextDay()<CR>
map <Leader>td :call InsertToday()<CR>

function! InsertToday()
    " Grab postponed or blocked todos from the top of the current file
    let rollover_todos = GetRolloverTodos()
    let repeats = LoadRepeatTodos(0)

    :normal! ggO
    :call Insert("{".Strip(system('powershell "[DateTime]::Today.ToString("""yyyy-MM-dd""")"'))."}")
    
    :normal! 2o
    for repeat in repeats
        :call Insert("\t")
        :call Insert(repeat[0] . "[] " . repeat[2] . "\n")
    endfor
    
    if !empty(rollover_todos)
        :call Insert("\t")
        :call Insert(rollover_todos)
    endif
endfunction

function! InsertNextDay()
    " Grab postponed or blocked todos from the top of the current file
    let rollover_todos = GetRolloverTodos()
    let repeats = LoadRepeatTodos(1)

    " Insert header for tomorrow's date
    :normal! ggO
    :call Insert("{".Strip(system('powershell "[DateTime]::Today.AddDays(1).ToString("""yyyy-MM-dd""")"'))."}")
    ":call Insert("{".Strip(system('date "--date=tomorrow" "+%Y-%m-%d"'))."}")
    
    :normal! 2o
    for repeat in repeats
        :call Insert("\t")
        :call Insert(repeat[0] . "[] " . repeat[2] . "\n")
    endfor
    
    if !empty(rollover_todos)
        :call Insert("\t")
        :call Insert(rollover_todos)
    endif
endfunction

function! GetRolloverTodos()
    :1,/{.*}/-s/\%(\S\+>\)*\[\(>\|!\|&\)\].*\n/\=setreg('A', submatch(0), 'V')/ne
    let rollover_todos = getreg("a")
    :call setreg("a", "")
    return rollover_todos
endfunction

" Quickly edit todos
nnoremap <Leader>te :cd $TODO_DIR<CR>:e intentions.txt<CR>:tabnew repeat.txt<CR>:tabnew todo-unsched.txt<CR>:tabnew todo.txt<CR>ggzM2jzO

" Always load intention highlight rules when opening todo-related files
au BufReadPost,BufNewFile todo*.txt,repeat.txt,intentions.txt call LoadIntentions()

" Quickly incr and decr counters, regardless of cursor position
map <Leader><C-a> :call IncrementCounter()<CR><Esc>
map <Leader><C-x> :call DecrementCounter()<CR><Esc>

" Todo statuses:
" Done      = /
" Partial   = &
" Skipped   = -
" Postponed = >
" Blocked   = !

map <Leader>d :call ToggleDone()<CR><Esc>
map <Leader>pa :call TogglePartial()<CR><Esc>
map <Leader>sp :call ToggleSkipped()<CR><Esc>
map <Leader>pd :call TogglePostponed()<CR><Esc>
map <Leader>bl :call ToggleBlocked()<CR><Esc>
map <Leader>to :call SetTodo()<CR><Esc>

function! ToggleTodoStatus(match_pattern, match_replace)
    let status_match = matchstr(getline('.'), '\[' . a:match_pattern . '\]')
    if empty(status_match)
        exec 's/\[.*\]/[' . a:match_replace . ']/ge'
    else
        call SetTodo()
    endif
endfunction

function! SetTodo()
    let any = matchstr(getline('.'), '\[.*\]')
    if !empty(any)
        s/\[.*\]/[]/ge
    else
        exe 'norm!I[] ' 
    endif
endfunction

function! ToggleDone()
    call ToggleTodoStatus('/', '\/')
endfunction

function! TogglePartial()
    call ToggleTodoStatus('&', '\&')
endfunction

function! ToggleSkipped()
    call ToggleTodoStatus('-', '-')
endfunction

function! TogglePostponed()
    call ToggleTodoStatus('>', '>')
endfunction

function! ToggleBlocked()
    call ToggleTodoStatus('!', '!')
endfunction

" Custom todo functions
function! IncrementCounter()
    mark `
    s/\[\(\d\+\)\(.*\)\]/\="\[".(submatch(1)+1).submatch(2)."\]"/ge
    normal ``
endfunction

function! DecrementCounter()
    mark `
    s/\[\(\d\+\)\(.*\)\]/\="\[".(submatch(1)-1).submatch(2)."\]"/ge
    normal ``
endfunction

" Improved fold navigation
nnoremap <silent> <leader>zj :call NextFold('j')<cr>
nnoremap <silent> <leader>zk :call NextFold('k')<cr>
function! NextFold(dir)
    exe 'norm!zcz' . a:dir . 'zo'
endfunction

" Color highlighting for intentions
map <Leader>ll :call ReloadIntentions()<CR><Esc>

function! ReloadIntentions()
    call clearmatches()
    call LoadIntentions()
endfunction

function! LoadIntentions()
    
    " Misc todo items
    hi i_misc guibg=#fdf6e3 guifg=grey
    call matchadd('i_misc', '^\s*&&>')

    " Priorities
    hi prio guifg=red
    call matchadd('prio', '<PRIO>')

    " Load user-defined colors
    let all_intentions = ParseIntentions()    
    for intention in all_intentions
        let intention_id  = intention[0]
        let intention_bg  = intention[1]
        let intention_fg  = intention[2]
        let hi_rule       = 'i' . intention_id
        
        "let intention_match_line    = '^\\s*' . intention_id . '>.*$'
        let intention_match_indent  = '^\\s*' . intention_id . '>'
        let intention_match_literal = intention_id . '>'

        exe 'hi ' . hi_rule . ' guibg=' . intention_bg . ' guifg=' . intention_fg
        exe 'call matchadd("' . hi_rule . '", "' . intention_match_indent . '")'
        exe 'call matchadd("' . hi_rule . '", "' . intention_match_literal . '")'
    endfor
endfunction

function! ParseIntentions()
    let intentions_full_path = $TODO_DIR . '\intentions.txt'
    let all_lines = readfile(intentions_full_path)
    let all_intentions = []
    for line in all_lines
        " Example intention:
        " 1>(#000000:#ffffff) Some description 
        let matches = matchlist(line, '^\s*\(\d\+\)>\[\(.\{3,10}\):\(.\{3,10}\)\]\s*\(.\+\)$')
        if !empty(matches)
            let intention_id = matches[1]
            let intention_bg = matches[2]
            let intention_fg = matches[3]
            call add(all_intentions, [intention_id, intention_bg, intention_fg])
        endif
    endfor
    return all_intentions
endfunction

function! LoadRepeatTodos(day_offset)
    let repeat_full_path = $TODO_DIR . '\repeat.txt'
    let all_lines = readfile(repeat_full_path)
    let all_repeats = []
    for line in all_lines
        let matches = matchlist(line, '^\s*\(\%(.\+>\)*\)\[\(\d\{1,7}\)*\]\s*\(.\+\)$')
        if !empty(matches)
            let intention_id = matches[1]
            let repeat_pattern = matches[2]
            let text = matches[3]

            let days_of_week = []
            let should_repeat = 0

            if empty(repeat_pattern)
                let days_of_week = [1,2,3,4,5,6,7]    
                let should_repeat = 1
            else
                let weekday = strftime("%w")
                let repeat_day = (weekday + a:day_offset)
                if repeat_day > 7
                    let repeat_day = repeat_day % 7
                endif
                for day_of_week in split(repeat_pattern, '\zs')
                    call add(days_of_week, day_of_week)
                    if day_of_week == repeat_day
                        let should_repeat = 1
                    endif
                endfor
            endif

            let repeat = [intention_id, days_of_week, text]
            if should_repeat == 1
                call add(all_repeats, repeat)
            endif
        endif
    endfor
    return all_repeats
endfunction
