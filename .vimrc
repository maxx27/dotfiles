" After editing this file
" - reload seeting from it :so %
" - :so $MYVIMRC

" Enable/disable command patterns:
" :set XYZ / :set noXYZ
" :XYZ on / :XYZ off

" Show option value:
" :set expandtab?

"====================================
" GENERAL
"====================================

set nocompatible                    " Forget compatibility with Vi

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

set shortmess+=I                    " Don't show the Vim welcome screen.

set magic                           " Set magic on, for regex

" noremap / /\v                       " Use perl-ish regexp style, otherwise use :s/\vfoo/bar/g for substitutions

" Enable mouse support if it's available
if has("mouse")
    set mousehide                   " hide the mouse cursor when typing
    set mouse=a                     " full mouse support / `set mouse=` to disable mouse
    set ttymouse=xterm2
endif

set autowrite                       " Automatically :write before running commands
set autoread                        " Reload files changed outside vim
"set hidden                          " Switch between buffers without saving

"set splitright                     " split new vertical windows right of current window
"set splitbelow                     " split new horizontal windows under current window

"set clipboard=unnamed               " Yank to the system clipboard

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
highlight search ctermbg=5          " highlight background color
set ignorecase                      " ignore case for pattern matches
set smartcase                       " override 'ignorecase' if pattern contains uppercase

" highlight conflicts
" error messages on the command line
"match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

filetype on                         " enable file type detection
filetype plugin on                  " load options and mappings only for current buffer

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
    set antialias
else
    set term=xterm                  " allow use arrows and other special keys
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
set spell
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

" Fast saving current buffer (only when the buffer has been modified)
nnoremap <leader>w :update!<cr>

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


" Easier moving between tabs
"nmap <leader>[ :tabprevious<cr>
"nmap <leader>[ :tabnext<cr>
"nmap <leader>t :tabnew<cr>

" Change directory to current buffer
map <leader>cd :cd %:p:h<cr>

"noremap <leader>d :BW!<cr>         " https://habr.com/post/149817/
"noremap <leader>. <C-^>            " edit alternative file

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
