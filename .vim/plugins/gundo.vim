"====================================
" Visualize undo tree
"====================================
if has('python')
    Plug 'sjl/gundo.vim'
    nnoremap <leader>tu :GundoToggle<cr>
endif
" NOW WE CAN:
" :GundoToggle toggle gundo tree
