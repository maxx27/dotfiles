"====================================
" Comment blocks
"====================================
Plug 'tpope/vim-commentary'
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
