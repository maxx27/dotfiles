"====================================
" Visualize undo tree
"====================================
if has('python') " python3 is unsupported
    Plug 'sjl/gundo.vim'
    nnoremap <leader>tu :GundoToggle<cr>
endif
" NOW WE CAN:
" :GundoToggle toggle gundo tree
