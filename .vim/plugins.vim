call plug#begin('~/.vim/plugged')
" See https://github.com/junegunn/vim-plug
" :PlugInstall to install plugins
" :PlugClean to remove disabled plugins

Plug 'tpope/vim-repeat'                    "allow plugins to utilize . command

" surround.vim
Plug 'tpope/vim-surround'                  " for manipulating parens and such
nmap <silent> dsf ds)db

" Comment blocks
"Plug 'tpope/vim-commentary'
" NOW WE CAN:
" Toggle comments:
" :gcc to comment out a line (takes a count)
" :gc  to comment out the target of a motion (for example, gcap to comment out a paragraph)
" :gc  in visual mode to comment out the selection
" :gc  in operator pending mode to target a comment
" You can also use it as a command, either with a range like :7,17Commentary,
" or as part of a :global invocation like with :g/TODO/Commentary
" gcgc uncomments a set of adjacent commented lines
" You just have to adjust 'commentstring'
" autocmd FileType apache setlocal commentstring=#\ %s
"autocmd FileType vim setlocal commentstring="\ %s

" Fugitive
Plug 'tpope/vim-fugitive'                  " Git utilities
noremap <leader>gd :Gdiff<cr>
noremap <leader>gc :Gcommit -v<cr>
noremap <leader>gs :Gstatus<cr>

" Syntastic = Code linting
"Plug 'scrooloose/syntastic' "Run linters and display errors etc
"nmap <leader>err :Errors<CR><C-W>j
"noremap <leader>y :SyntasticCheck<cr>

" search filesystem with ctrl+p
Plug 'ctrlpvim/ctrlp.vim'
" NOW WE CAN:
" :CtrlP or :CtrlP [starting-directory] to invoke CtrlP in find file mode
" :CtrlPBuffer or :CtrlPMRU to invoke CtrlP in find buffer or find MRU file mode
" :CtrlPMixed to search in Files, Buffers and MRU files at the same time
" Once CtrlP is open:
" Press <F5> to purge the cache for the current directory to get new files, remove deleted files and apply new ignore options.
" Press <c-f> and <c-b> to cycle between modes.
" Press <c-d> to switch to filename only search instead of full path.
" Press <c-r> to switch to regexp mode.
" Use <c-j>, <c-k> or the arrow keys to navigate the result list.
" Use <c-t> or <c-v>, <c-x> to open the selected entry in a new tab or in a new split.
" Use <c-n>, <c-p> to select the next/previous string in the prompt's history.
" Use <c-y> to create a new file and its parent directories.
" Use <c-z> to mark/unmark multiple files and <c-o> to open them.

" NERDTree
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFocus', 'NERDTreeFind'] }
"Plug 'Xuyuanp/nerdtree-git-plugin'

let g:NERDTreeHighlightCursorline=1
let g:NERDTreeShowHidden=1
let g:NERDTreeMinimalUI=1                  " disables the 'Bookmarks' label 'Press ? for help' text
let g:NERDTreeWinSize=40
let g:NERDTreeAutoDeleteBuffer=1           " automatically remove a buffer when a file is being deleted or renamed via a context menu command
let g:NERDTreeRespectWildIgnore = 1        " respect |'wildignore'|
let g:NERDTreeIgnore=['\~$', '\.pyc', '__pycache__']

function! ToggleNerdTree()
    if @% != "" && (!exists("g:NERDTree") || (g:NERDTree.ExistsForTab() && !g:NERDTree.IsOpen()))
        :NERDTreeFind
    else
        :NERDTreeToggle
    endif
endfunction

map <silent> <Leader>n :call ToggleNerdTree()<CR>
" Close vim if only NERDTree is open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" NOW WE CAN:
" :bookmark <desired bookmark name>
" B: bring up your list of available bookmarks
" t: Open the selected file in a new tab
" i: Open the selected file in a horizontal split window
" s: Open the selected file in a vertical split window
" I: Toggle hidden files
" m: Show the NERD Tree menu
" R: Refresh the tree, useful if files change outside of Vim
" ?: Toggle NERD Tree's quick help

" Diary, notes, whatever. It's amazing
"Plug 'vimwiki/vimwiki'

" Several plugins to help work with Tmux
"Plug 'christoomey/vim-tmux-navigator'      " Easy movement between vim and tmux panes
"Plug 'https://github.com/christoomey/vim-tmux-runner'
"Plug 'christoomey/vim-run-interactive'
" Allow moving around between Tmux windows
"nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
"nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
"nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
"nnoremap <silent> <C-l> :TmuxNavigateRight<cr>
"let g:tmux_navigator_no_mappings = 1
"let g:tmux_navigator_save_on_switch = 1
"Open a tmux pane with Node
"nnoremap <leader>node :VtrOpenRunner {'orientation': 'h', 'percentage': 50, 'cmd': 'node'}<cr>

" Opens a browser to preview markdown files
"Plug 'suan/vim-instant-markdown', {'do': 'npm install -g instant-markdown-d'}

call plug#end()

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
