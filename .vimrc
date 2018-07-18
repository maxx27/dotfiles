" After editing this file
" - reload seeting from it :so %
" - :so $MYVIMRC

" Если команда имеет формат `set XYZ`, тогда для обратного эффекта используется команда `set noXYZ`
" Если команда имеет формат `XYZ on`, тогда для обратного эффекта используется команда `XYZ off`

" enter current millenium
set nocompatible

set langmenu=en_US
let $LANG='en_US'

" enable syntax (except on mingw)
if !has("win32unix")
"let uname = system('uname -a')
"if uname !~ 'MINGW'
    "colorscheme cobalt2
    " colorscheme cobalt2_short
    " colorscheme cobalt2_1
endif
syntax enable

" make the backspace work like in most other programs
set backspace=indent,eol,start
nnoremap <BS> X

" enable plugin (for netrw)
filetype plugin on

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

" http://vim.wikia.com/wiki/Change_font
if has('gui_running')
    set guifont=Lucida_Console:h12
endif

" Allow use arrows
if !has('gui_running')
    set term=xterm
endif

" CDC = Change to Directory of Current file
" http://vim.wikia.com/wiki/Set_working_directory_to_the_current_file
command! CDC cd %:p:h

" Searcg down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**

" Display all matching files when we tab complete
set wildmenu
" NOW WE CAN:
" - Hit tab to :find by partial match
" - Use * to make it fuzzy
" - :b lets you autocomplete any open buffer

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

" FILE BROWSING:
" Tweaks for browsing
let g:netrw_banner=0       " disable annoying banner
let g:netrw_browse_split=4 " open in prior window
let g:netrw_altv=1         " open splits to the right
let g:netrw_liststyle=3    " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'
" NOW WE CAN:
" - :edit a folder to open a file browser
" - <CR>/v/t to open in an h-split/v-split/tab
" - check |netrw-browse-maps| for more mappings
" HOW TO:
" - edit over SSH?

" Search options: make it a highlighted incremental search
set hls is
" highlight background color
highlight search ctermbg=5
" Press Space to turn off highlighting and clear any message already displayed
"nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>
" Ignore case sensitivity when searching
set ignorecase


" http://vim.wikia.com/wiki/Converting_tabs_to_spaces
set autoindent        " always set autoindenting on
set tabstop=4         " show existing tab with 4 spaces width
set shiftwidth=4      " when indenting with '>', use 4 spaces width
set expandtab         " On pressing tab, insert spaces
set softtabstop=4     " On editing tab and BS count as 4 spaces
" NOW WE CAN:
" - Use :retab with a range
" - Use :.retab to convert only the current line to use spaces

" show line numbers
"set number
"set relativenumber

" show status bar    " всегда показывать строку состояния
"set laststatus=2

" show unprintable symbols $
" set listchars=eol:¬,tab:→→,extends:>,precedes:<
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
"set list
set nolist
noremap  <F5> :set list!<CR>
inoremap <F5> <C-o>:set list!<CR>
cnoremap <F5> <C-c>:set list!<CR>
" NOW YOU CAN:
" - Toggle to it so you can see the changes mid editing easily

" (no)wrap - динамический (не)перенос длинных строк
" set wrap

" показывать незавершенные команды в статусбаре (автодополнение ввода)
" set showcmd

" SNIPPETS:

" Read an empty HTML tempale and move cursor to title
nnoremap ,html :-1read $HOME/.vim/.skeleton.html<CR>3jwf>a

" BUILD INTEGRATION:
" Configure the `make` command to run the following
set makeprg=make\ -j\ $(nproc)
" NOW WE CAN:
" - Run :make to run the command above
" - :cl to list errors
" - :cc# to jump to error by number
" - :cn and :cp to navigate forward and back
