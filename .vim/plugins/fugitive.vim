"====================================
" Git utilities
"====================================
Plug 'tpope/vim-fugitive'
"noremap <leader>gd :Gdiff<cr>
"noremap <leader>gc :Gcommit -v<cr>
"noremap <leader>gs :Gstatus<cr>

" Each time you open a git object using fugitive it creates a new buffer.
" This means that your buffer listing can quickly become swamped with fugitive
" buffers. Here’s an autocommand that prevents this from becomming an issue:
autocmd BufReadPost fugitive://* set bufhidden=delete

" See series of screencases:
" http://vimcasts.org/blog/2011/05/the-fugitive-series/
" 31 http://vimcasts.org/episodes/fugitive-vim---a-complement-to-command-line-git/
" 32 http://vimcasts.org/episodes/fugitive-vim-working-with-the-git-index/
" 33 http://vimcasts.org/episodes/fugitive-vim-resolving-merge-conflicts-with-vimdiff/
" 34 http://vimcasts.org/episodes/fugitive-vim-browsing-the-git-object-database/
" 35 http://vimcasts.org/episodes/fugitive-vim-exploring-the-history-of-a-git-repository/
"
