"====================================
" Easy motion
"====================================
Plug 'easymotion/vim-easymotion'
" NOW WE CAN:
" <leader><leader>w - to activate plugin and select destination
" <leader><leader>fo - to find all character 'o'

" <Leader>f{char} to move to {chr}
"map  <Leader>f <Plug>(easymotion-bd-f)
"nmap <Leader>f <Plug>(easymotion-overwin-f)

" s{char}{char} to move to {char}{char}
"nmap s <Plug>(easymotion-overwin-f2)

" Move to line
"map <Leader>L <Plug>(easymotion-bd-jk)
"nmap <Leader>L <Plug>(easymotion-overwin-line)

" Move to word
"map  <Leader>w <Plug>(easymotion-bd-w)
"nmap <Leader>w <Plug>(easymotion-overwin-w)

" TODO: integrate with incsearch.vim
