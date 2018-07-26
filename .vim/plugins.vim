call plug#begin('~/.vim/plugged')
" See https://github.com/junegunn/vim-plug
" :PlugInstall to install plugins.

Plug 'tpope/vim-fugitive'                  " Git utilities
Plug 'tpope/vim-surround'                  " for manipulating parens and such
Plug 'tpope/vim-repeat'                    "allow plugins to utilize . command

" NERDTree
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFocus', 'NERDTreeFind'] }
let g:NERDTreeHighlightCursorline=1
let g:NERDTreeShowHidden=1
let g:NERDTreeMinimalUI=1
let g:NERDTreeWinSize=40
let g:NERDTreeIgnore=['\~$', '\.pyc', '__pycache__']

" NERDTree
" ---------------------------------------------------------------------
let g:NERDTreeAutoDeleteBuffer=1
let g:NERDTreeMinimalUI=1
let g:NERDTreeWinSize=40
let g:NERDTreeDirArrowExpandable = '▷'
let g:NERDTreeDirArrowCollapsible = '▼'
let g:NERDTreeRespectWildIgnore = 1

function! ToggleNerdTree()
    if @% != "" && (!exists("g:NERDTree") || (g:NERDTree.ExistsForTab() && !g:NERDTree.IsOpen()))
        :NERDTreeFind
    else
        :NERDTreeToggle
    endif
endfunction

map <silent> <Leader>n :call ToggleNerdTree()<CR>

" [2]
map <silent> <C-n> :NERDTreeToggle<cr>
nnoremap <C-t> :call ToggleRelativeOn()<cr>
" Close vim if only NERDTree is open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Several plugins to help work with Tmux
Plug 'christoomey/vim-tmux-navigator'      " Easy movement between vim and tmux panes
Plug 'https://github.com/christoomey/vim-tmux-runner'
Plug 'christoomey/vim-run-interactive'

" Allow moving around between Tmux windows
nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>
let g:tmux_navigator_no_mappings = 1
let g:tmux_navigator_save_on_switch = 1
"
"Open a tmux pane with Node
nnoremap <leader>node :VtrOpenRunner {'orientation': 'h', 'percentage': 50, 'cmd': 'node'}<cr>

" search filesystem with ctrl+p
Plug 'ctrlpvim/ctrlp.vim'

" Code linting
Plug 'scrooloose/syntastic' "Run linters and display errors etc

" [8] Diary, notes, whatever. It's amazing
Plug 'vimwiki/vimwiki'

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
