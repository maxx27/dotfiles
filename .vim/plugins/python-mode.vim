"====================================
" Turn Vim into Python IDE
"====================================
if has('python') || has('python3')
    Plug 'python-mode/python-mode', { 'branch': 'develop' }
    nnoremap <leader>tu :GundoToggle<cr>
endif

let g:pymode_python = 'python3'
