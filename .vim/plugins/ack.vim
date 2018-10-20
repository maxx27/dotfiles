
"====================================
" Use Ack/ag as external search tool
"====================================
if executable('ag')
    Plug 'mileszs/ack.vim'
    " See https://github.com/rking/ag.vim/issues/124#issuecomment-227038003
    let g:ackprg = 'ag --vimgrep --smart-case'
    " cnoreabbrev ag Ack
    " cnoreabbrev aG Ack
    " cnoreabbrev Ag Ack
    " cnoreabbrev AG Ack
endif
" NOW WE CAN:
" Ack[!] {pattern} [{directory}]  - search for pattern in files
" AckAdd {pattern} [{directory}]  - the same but add results
" LAck {pattern} [{directory}]    - use location list
" AckFile {pattern} [{directory}] - search in filenames
" AckHelp[!] {pattern}            - search in help
" AckWindow[!] {pattern}          - search in buffers of current tab
