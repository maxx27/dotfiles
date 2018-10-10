"====================================
" NERDTree
"====================================
"Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFocus', 'NERDTreeFind'] }
""Plug 'Xuyuanp/nerdtree-git-plugin'

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
