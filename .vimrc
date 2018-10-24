" After editing this file
" - reload seeting from it :so %
" - :so $MYVIMRC

" Enable/disable command patterns:
" :set XYZ / :set noXYZ
" :XYZ on / :XYZ off

" Show option value:
" :set expandtab?

let s:is_win = has('win32') || has('win64')
let s:is_nvim = has('nvim')

"====================================
" Fix home folder
"====================================
if s:is_win && $HOME == 'U:\'
    let $HOME = $USERPROFILE
endif

"====================================
" PLUGINS
"====================================

" Check for vim-plug; install if missing
let plugpath = expand('<sfile>:p:h') . '/.vim/autoload/plug.vim'
if !filereadable(plugpath)
    if executable('curl')
        call system('curl -fLo ' . shellescape(plugpath) . ' --create-dirs ' .
            \ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
        if v:shell_error
            echo "Error downloading vim-plug. Please install it manually.\n"
            exit
        endif
    else
        echo "Unable to download vim-plug. Please install it manually or install curl.\n"
        exit
    endif
endif

" Load up all of our plugins
if filereadable(expand("~/.vim/plugins.vim"))
    source ~/.vim/plugins.vim
endif


"====================================
" GENERAL
"====================================

set nocompatible                    " Forget compatibility with Vi

let $LANG='en_US'
if s:is_nvim
    " Neovim
elseif s:is_win
    " gVim
    language English_United States
    if has("menu") && has("multi_lang")
        set langmenu=en_US.UTF-8
        source $VIMRUNTIME/delmenu.vim
        source $VIMRUNTIME/menu.vim
    endif
else
    " Linux and others
    language en_US.utf8
    if has("menu") && has("multi_lang")
        set langmenu=en_US
    endif
endif

" http://vim.wikia.com/wiki/Working_with_Unicode
if has("multi_byte")
    if &termencoding == ""
        let &termencoding = &encoding
    endif
    set encoding=utf-8
    setglobal fileencoding=utf-8
    "setglobal nobomb                " Don't insert BOM automatically
endif

set shortmess+=I                    " Don't show the Vim welcome screen.
set magic                           " Set magic on, for regex

" noremap / /\v                       " Use perl-ish regexp style, otherwise use :s/\vfoo/bar/g for substitutions

" Enable mouse support if it's available
if has("mouse")
    set mousehide                   " hide the mouse cursor when typing
    set mouse=a                     " full mouse support / `set mouse=` to disable mouse
    if !s:is_nvim
        set ttymouse=xterm2
    endif
endif

"set autowrite                       " automatically :write before running commands
"set autoread                        " reload files changed outside vim
set hidden                           " switch between buffers without saving

set splitright                       " split new vertical windows right of current window
set splitbelow                       " split new horizontal windows under current window

"set clipboard=unnamed               " Yank to the PRIMARY "* (system) clipboard
"set clipboard=unnamedplus           " or yank to the CLIPBOARD "+ (X11) clipboard


" Search down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**

" Display all matching files when we tab complete
set wildmenu
"set wildmode=list:longest           " complete files like a shell
set completeopt+=longest
set completeopt-=preview             " Don't show the preview window when completing
" ignore binary files in the standard vim file finder
set wildignore+=*build/**,*.pyc,*.obj

" NOW WE CAN:
" - Hit tab to :find by partial match
" - Use * to make it fuzzy
" - :b lets you autocomplete any open buffer

set incsearch                       " go to search results as typing
set hlsearch                        " highlight search things
                                    "
highlight search ctermbg=5          " highlight background color
set ignorecase                      " ignore case for pattern matches
set smartcase                       " override 'ignorecase' if pattern contains uppercase

" highlight conflicts
" error messages on the command line
"match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

filetype plugin indent on           " enable file type detection and load plugins for this type

"====================================
" Swap and undo settings
"====================================

set nobackup                        " do not keep backup files
set backupcopy=yes                  " Overwrite the original file when saving

set directory^=~/.vim/.tmp          " swap directory
set updatecount=20                  " update the swap file every 20 characters

set undolevels=1000
set undofile
set undodir=~/.vim/.undo

"====================================
" APPEARANCE
"====================================

" see plugins/colorschemes.vim for colorscheme settings
set background=dark
if s:is_nvim
    " colorscheme PaperColor
    colorscheme afterglow
elseif has("win32unix")
    " for MinGW another scheme
    colorscheme PaperColor
else
    colorscheme cobalt2
endif

set ruler                           " Always show current position
set showcmd                         " Show typed commands in the cmd area
set showmode                        " Display the mode you're in
set laststatus=2                    " Always show the statusline

" line numbers
set number                          " Show line numbers
set relativenumber                  " Show relative numbers
set numberwidth=4                   " Minimum of 4 columns for line numbers

set cursorline                      " Highlight current line for quick orientation

set scrolloff=3                     " Show 3 lines of context around the cursor (top and bottom)
set sidescrolloff=5                 " Show 5 lines of context around the cursor (left and right)
set sidescroll=1                    " Number of chars to scroll when scrolling sideways

set nowrap                          " Don't wrap text by default

set list                            " Show unprintable symbols $
set listchars=eol:¬,tab:→→,extends:>,precedes:<
" set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
" set listchars=tab:→\ ,eol:¬,trail:⋅,extends:❯,precedes:❮
set showbreak=↪

" http://vim.wikia.com/wiki/Change_font
if s:is_nvim
    " gui_running is false for Neovim
    set guifont=Ubuntu\ Mono\ derivative\ Powerline:h12:cDEFAULT
endif

if has('gui_running')
    if s:is_win
        " set guifont=Ubuntu_Mono_derivative_Powerlin:h12:cDEFAULT
    else
        set guifont=Cousine\ for\ Powerline\ 10
    endif
    set antialias
else
    if !s:is_nvim
        set term=xterm              " allow use arrows and other special keys
    endif
    set t_Co=256                    " set 256 colors
    let &t_AB="\e[48;5;%dm"
    let &t_AF="\e[38;5;%dm"
endif

if &term =~ '256color'
    set t_ut=                       " disable background color erase
endif

" enable 24 bit color support if supported
if empty($TMUX) && has("termguicolors")
    set termguicolors
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.

" enable syntax
syntax off
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
    syntax on

    " Highlight trailing whitespaces
    highlight ExtraWhitespace ctermbg=red guibg=red
    match ExtraWhitespace /\s\+$/
    autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
    autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
    autocmd InsertLeave * match ExtraWhitespace /\s\+$/
    autocmd BufWinLeave * call clearmatches()
    " Show trailing whitepace and spaces before a tab:
    autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/
endif

"" error bells
"set noerrorbells
"set visualbell
"set t_vb=
"set tm=500

set diffopt+=vertical               " Always use vertical diffs

set equalalways                     " Split with the same size
set eadirection=both                " for both vertical and horizontal splits
" Opening and closing a window:
" - Use C-w s or :split  to split current window in two horizontally
" - Use C-w v or :vsplit to split current window in two vertically
" - Use C-w n or :new    to create a new window with empty file horizontally
" - Use          :vnew   to create a new window with empty file vertically
" - Use C-w q or :quit   to quit current window
" - Use C-w c or :close  to close current window
" - Use C-w o or :only   to make the current window the only one on the screen. All other windows are closed
" Moving cursor to other windows:
" - Use C-arrow or C-hjkl to move cursor to Nth window left/below/above/right of current one.
" - Use C-w w or C-w C-w to move cursor to window below/right of the current one
" - Use C-w W or C-w C-W to move cursor to window above/left of current one
" - Use C-w t or C-w C-t to move cursor to top-left window
" - Use C-w b or C-w C-b to move cursor to bottom-right window
" - Use C-w p or C-w C-p to go to previous (last accessed) window
" - Use C-w P            to go to preview window
" Moving windows around:
" - Use C-w x to exchange current window with next one
" - Use C-w r to rotate windows downwards/rightwards
" - Use C-w R to rotate windows upwards/leftwards
" - Use C-w K to move the current window to be at the very top, using the full width of the screen
" - Use C-w J to move the current window to be at the very bottom, using the full width of the screen
" - Use C-w H to move the current window to be at the far left, using the full height of the screen
" - Use C-w L to move the current window to be at the far right, using the full height of the screen
" - Use C-w T to move the current window to a new tab page
" Window resizing:
" - Use C-w =               to make all windows (almost) equally high and wide
" - Use C-w - or :resize -N to decrease current window height by N (default 1)
" - Use C-w + or :resize +N to increase current window height by N (default 1)
" - Use C-w <               to decrease current window width by N (default 1).
" - Use C-w >               to increase current window width by N (default 1).


"====================================
" Editing
"====================================

" make the backspace work like in most other programs
set backspace=indent,eol,start
nnoremap <BS> X

" http://vim.wikia.com/wiki/Converting_tabs_to_spaces
set autoindent                      " always set autoindenting on
set nosmartindent                   " 'smartindent' breaks right-shifting of # lines
set tabstop=4                       " show existing tab with 4 spaces width
set shiftwidth=4                    " when indenting with '>', use 4 spaces width
set expandtab                       " On pressing tab, insert spaces
set softtabstop=4                   " On editing tab and BS count as 4 spaces
" NOW WE CAN:
" - Use :retab with a range
" - Use :.retab to convert only the current line to use spaces

set nomodeline                      " Ignore modelines
set nojoinspaces                    " Only insert 1 space after a period when joining lines
set textwidth=0                     " don't auto-wrap lines except for specific filetypes

set formatoptions+=ron              " Automatically format comments and numbered lists

"====================================
" SPELL
"====================================
set nospell                         " No spell by default
set spelllang=ru,en
" Underline words with errors
highlight clear SpellBad
highlight SpellBad cterm=underline

" rebuild the .spl file each time the .add file has been updated when vim is started
for d in glob('~/.vim/spell/*.add', 1, 1)
    if filereadable(d) && (!filereadable(d . '.spl') || getftime(d) > getftime(d . '.spl'))
        exec 'mkspell! ' . fnameescape(d)
    endif
endfor

"====================================
" BUILD INTEGRATION
"====================================

" Configure the `make` command to run the following
set makeprg=make\ -j\ $(nproc)
" NOW WE CAN:
" - Run :make to run the command above
" - :cl to list errors
" - :cc# to jump to error by number
" - :cn and :cp to navigate forward and back

"====================================
" General Mappings
"====================================

" Use Russian layout during command mode
"set keymap=russian-jcukenwin
"set iminsert=0
"set imsearch=0
" Use another cursor color when language mapping are being used
"highlight Cursor guifg=NONE guibg=Green
"highlight lCursor guifg=NONE guibg=Cyan

" Set mapleader
let mapleader = ","
let g:mapleader = ","
" Map default leader to what , does normally
nnoremap \ ,


" Quicker way to press ESC
" imap ;; <Esc>
" vmap ;; <Esc>

" Quicker access to Ex commands
" nnoremap ; :
" nnoremap : ;
" vnoremap ; :
" vnoremap : ;
nmap ; :
xmap ; :

imap <C-Enter> I just pressed Control+Enter<CR>
imap <C-S-Enter> I just pressed Control+Shift+Enter<CR>

" Insert single character (insert placeholder before then wait for single character
" https://superuser.com/questions/581572/insert-single-character-in-vim
nnoremap <C-i> i_<Esc>r
"nnoremap ,i i_<Esc>r
"nnoremap ,a a_<Esc>r

" Fast reloading of the .vimrc
noremap <leader>sr :source $MYVIMRC<cr>
" Fast editing of .vimrc
noremap <leader>se :e! $MYVIMRC<cr>

" Toggle highlighting
nmap <leader>th :set hlsearch! \| set hlsearch?<cr>

" Toggle unprintable characters
nmap <leader>tl :set list! \| set list?<cr>

" Toggle paste indent
map <leader>tp :set paste! \| set paste?<cr>
" set pastetoggle=<F2> "F2 before pasting to preserve indentation
" "Copy paste to/from clipboard
" vnoremap <C-c> "*y
" map <silent><Leader>p :set paste<CR>o<esc>"*]p:set nopaste<cr>"
" map <silent><Leader><S-p> :set paste<CR>O<esc>"*]p:set nopaste<cr>"

" Toggle mouse
map <leader>tm :exec &mouse!=""? "set mouse=" : "set mouse=a" \| echo "Mouse mode is " . &mouse<cr>

" Toggle spell checking
map <leader>ts :setlocal spell! \| setlocal spell?<cr>

" grep for word under cursor in current file
map <leader>gwf :execute 'vimgrep /'.expand('<cword>').'/gj '.expand('%') \| copen<cr>
" grep for word under cursor in files with the same extention
map <leader>gwe :execute 'vimgrep /'.expand('<cword>').'/gj *'.(expand('%:e')=='' ? '' : '.'.expand("%:e")) \| copen<cr>

" Easy navigation
" nmap <C-TAB> :bprevious<cr>
" nmap <TAB> :bnext<cr>

" (like in vim-unimpaired plugin)
nmap [w <C-w>W
nmap ]w <C-w>w
" nmap [T :tabprevious<cr>
" nmap [t :tabnext<cr>

" Change directory to current buffer
map <leader>cd :cd %:p:h<cr>

" ,cs copies just the filename
" ,cl copies the filename including its full path
if has('clipboard')
    if s:is_win
        " convert slashes to backslashes for Windows as well
        nmap <leader>cs :let @*=substitute(expand("%"), "/", "\\", "g")<cr>
        nmap <leader>cl :let @*=substitute(expand("%:p"), "/", "\\", "g")<cr>
    else
        nmap <leader>cs :let @*=expand("%")<cr>
        nmap <leader>cl :let @*=expand("%:p")<cr>
    endif
endif

"noremap <leader>d :BW!<cr>         " https://habr.com/post/149817/

"====================================
" SNIPPETS
"====================================

" Read an empty HTML template and move cursor to title
"nnoremap ,html :-1read $HOME/.vim/.skeleton.html<CR>3jwf>a

"====================================
" COMMANDS
"====================================

" Create the `tags` file (may need to install ctags first)
command! MakeTags !ctags -R .
" NOW WE CAN:
" - Use ^] to jump to tag under cursor
" - Use g^] for ambiguous tags
" - Use ^t to jump back up the tag stack

" AUTOCOMPLETE:
" The good stuff is documented in |ins-completion|
" HIGHLIGHTS:
" - ^x^l for whole lines
" - ^x^n for keywords forward
" - ^x^p for keywords backward
" - ^x^k for keywords in 'dictionary'
" - ^x^t for keywords in 'thesaurus'
" - ^x^i for keywords in the current and included files
" - ^x^] for tags only
" - ^x^f for filenames (works with our path trick!)
" - ^x^d for definitions or macros
" - ^x^v for vim command-line
" - ^x^u for user defined completion
" - ^x^o for omni completion
" - ^x^s for spelling suggestions
" - ^n for anything specified by the 'complete' option
" NOW WE CAN:
" - Use ^n and ^p to go back and forth in the suggestion list

"====================================
" FUNCTIONS
"====================================

if filereadable(expand("~/.vim/functions.vim"))
    source ~/.vim/functions.vim
endif

"====================================
" LOCAL CONFIG
"====================================

if filereadable(expand("~/.vim.local"))
    source ~/.vim.local
endif


