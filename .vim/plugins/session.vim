"====================================
" Session management
"====================================
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'
" NOW WE CAN:
" :SaveSession
" :OpenSession
" :CloseSession
" :DeleteSession
" :ViewSession
" :OpenTabSession
" :SaveTabSession
" :AppendTabSession
" :CloseTabSession
" :RestartVim (works in gvim only)

set sessionoptions-=tabpages                " If you only want to save the current tab page:
set sessionoptions-=help                    " If you don't want help windows to be restored:set sessionoptions-=buffers                 " Don't save hidden and unloaded buffers in sessions.
set sessionoptions-=options                 " Don't persist options and mappings because it can corrupt sessions.

let g:session_directory='~/.vim/sessions'
let g:session_autoload = "no"
let g:session_autosave = "no"
