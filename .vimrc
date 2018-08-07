" After editing this file
" - reload seeting from it :so %
" - :so $MYVIMRC

" Enable/disable command patterns:
" set XYZ / set noXYZ
" XYZ on / XYZ off

"====================================
" GENERAL
"====================================

set nocompatible                    " enter current millenium

if has("menu") && has("multi_lang")
    language en_US.utf8
    set langmenu=en_US
    let $LANG='en_US'
endif

" http://vim.wikia.com/wiki/Working_with_Unicode
if has("multi_byte")
    if &termencoding == ""
        let &termencoding = &encoding
    endif
    set encoding=utf-8
    setglobal fileencoding=utf-8
    "setglobal bomb
    set fileencodings=ucs-bom,utf-8,latin1
endif

set spelllang=en

set shortmess+=I                    " Don't show the Vim welcome screen.

set magic                           " Set magic on, for regex

" noremap / /\v                       " Use perl-ish regexp style, otherwise use :s/\vfoo/bar/g for substitutions

" Enable mouse support if it's available
if has("mouse")
    set mousehide                   " hide the mouse cursor when typing
    set mouse=a                     " full mouse support
    set ttymouse=xterm2
endif

set autowrite                       " Automatically :write before running commands
set autoread                        " Reload files changed outside vim

"set splitright                     " split new vertical windows right of current window
"set splitbelow                     " split new horizontal windows under current window

set clipboard=unnamed               " Yank to the system clipboard

" Search down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**

" Display all matching files when we tab complete
set wildmenu
"set wildmode=list:longest           " complete files like a shell
set completeopt+=longest
set completeopt-=preview             " Don't show the preview window when completing
set wildignore+=*.pyc,*.obj,*.bin,a.out " Ignore binary files in the standard vim file finder

" NOW WE CAN:
" - Hit tab to :find by partial match
" - Use * to make it fuzzy
" - :b lets you autocomplete any open buffer

set incsearch                       " go to search results as typing
set hlsearch                        " highlight search things
highlight search ctermbg=5          " highlight background color
set ignorecase                      " ignore case for pattern matches
set smartcase                       " override 'ignorecase' if pattern contains uppercase

" enable plugin (for netrw)
filetype plugin on

"====================================
" Swap and undo files and directories
"====================================

set nobackup                        " do not keep backup files
set backupcopy=yes                  " Overwrite the original file when saving
set directory^=~/.vim/.tmp//        " swap directory
set updatecount=20                  " update the swap file every 20 characters

set undolevels=1000
if v:version >= 703                 " options only for Vim >= 7.3
    set undofile
    set undodir=~/.vim/.undo        " undo file directory
endif

"====================================
" APPEARANCE
"====================================

" enable syntax (except on mingw)
if !has("win32unix")
"let uname = system('uname -a')
"if uname !~ 'MINGW'
    colorscheme cobalt2
    " colorscheme cobalt2_short
    " colorscheme cobalt2_1
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
syntax off
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
    syntax on
endif


set ruler                           " always show current position
set showcmd                         " Show typed commands in the cmd area
set showmode                        " display the mode you're in
set laststatus=2                    " always show the statusline

" line numbers
set nonumber         " show line numbers
set norelativenumber
set numberwidth=4    " minimum of 4 columns for line numbers

set nocursorline                    " (!) highlight current line, for quick orientation

set scrolloff=3                     " show 3 lines of context around the cursor (top and bottom)
set sidescrolloff=5                 " show 5 lines of context around the cursor (left and right)
set sidescroll=1                    " number of chars to scroll when scrolling sideways

set nowrap                          " Don't wrap text by default

set list                  " show unprintable symbols $
set listchars=eol:¬,tab:→→,extends:>,precedes:<
" set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
" set listchars=tab:→\ ,eol:¬,trail:⋅,extends:❯,precedes:❮
set showbreak=↪

" http://vim.wikia.com/wiki/Change_font
if has('gui_running')
    set guifont=Lucida_Console:h12
    " set antialias
else
    set term=xterm " Allow use arrows
    set t_Co=256 " set 256 colors
    let &t_AB="\e[48;5;%dm"
    let &t_AF="\e[38;5;%dm"
endif

if &term =~ '256color'
    set t_ut=                       " disable background color erase
endif

" switch cursor to line when in insert mode, and block when not
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
\,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
\,sm:block-blinkwait175-blinkoff150-blinkon175

" enable 24 bit color support if supported
if has('mac') && empty($TMUX) && has("termguicolors")
    set termguicolors
endif

" highlight conflicts
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

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

" Set mapleader
let mapleader = ","
let g:mapleader = ","
" Map default leader to what , does normally
nnoremap \ ,

" Fast saving
nnoremap <leader>w :up!<cr>
" Fast reloading of the .vimrc
noremap <leader>s :source $MYVIMRC<cr>
" Fast editing of .vimrc
noremap <leader>v :e! $MYVIMRC<cr>

" toggle spell checking
map <leader>spell :setlocal spell!<cr>

" toggle `set list`
nmap <leader>l :set list!<cr>

" Change directory to current buffer
map <leader>cd :cd %:p:h<cr>

" noremap <leader>t :tabnew<cr>
" noremap <C-j> :bn<CR>
" noremap <C-k> :bp<CR>
noremap <leader>d :BW!<cr>
noremap <leader>. <C-^>

" Quicker window movement
"nnoremap <C-j> <C-w>j
"nnoremap <C-k> <C-w>k
"nnoremap <C-h> <C-w>h
"nnoremap <C-l> <C-w>l
noremap <silent> <C-h> :call WinMove('h')<cr>
noremap <silent> <C-j> :call WinMove('j')<cr>
noremap <silent> <C-k> :call WinMove('k')<cr>
noremap <silent> <C-l> :call WinMove('l')<cr>
noremap <leader>q :wincmd q<cr>


" Remap code completion from Ctrl+x, Ctrl+o to Ctrl+Space
" inoremap <C-Space> <C-x><C-o>
" inoremap <C-@> <C-x><C-o>

" surround.vim
nmap <silent> dsf ds)db

" Fugitive
noremap <leader>gd :Gdiff<cr>
noremap <leader>gc :Gcommit -v<cr>
noremap <leader>gs :Gstatus<cr>

" Syntastic
"nmap <leader>err :Errors<CR><C-W>j
"noremap <leader>y :SyntasticCheck<cr>

" NERDTree
"nnoremap ,f :NERDTreeToggle<CR>
"nnoremap ,F :NERDTreeFocus<CR>

" Press Space to turn off highlighting and clear any message already displayed
"nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" set pastetoggle=<F2> "F2 before pasting to preserve indentation
" "Copy paste to/from clipboard
" vnoremap <C-c> "*y
" map <silent><Leader>p :set paste<CR>o<esc>"*]p:set nopaste<cr>"
" map <silent><Leader><S-p> :set paste<CR>O<esc>"*]p:set nopaste<cr>"

"====================================
" SNIPPETS
"====================================

" Read an empty HTML tempale and move cursor to title
nnoremap ,html :-1read $HOME/.vim/.skeleton.html<CR>3jwf>a

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
" - ^x^n for JUST this file
" - ^x^f for filenames (works with our path trick!)
" - ^x^] for tags only
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
