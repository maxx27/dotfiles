"====================================
" Manipulating parentheses and such
"====================================
Plug 'tpope/vim-surround'
" NOW WE CAN:
" ds - delete surroundings
"   ds" - delete surrounding quoute
"   ds) - delete surrounding parentheses
"   dst - delete surrounding tag
" cs - change surroundings
"   cs"'   - replace "" with ''
"   cs"<q> - replace "" with <q></q>
" ys - wraps an object with surrounding
"   ysiw)  - surround current word with ()
"   yss    - special case: operate on current line without leading whitespace
"   ySS    - special case: operate on whole current line
" See |surround-mappings| for visual mode.
