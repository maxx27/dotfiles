
"====================================
" Better * search in visual mode
"====================================
Plug 'bronson/vim-visual-star-search'
" NOW WE CAN:
" This allows you to select some text using Vim's visual mode and then hit *
" and # to search for it elsewhere in the file.  For example, hit V, select
" a strange sequence of characters like "$! $!", and hit star.  You'll find
" all other runs of "$! $!" in the file.
"
" If you hit <leader>* ("\*" unless you changed the mapleader), vim will
" recursively vimgrep for the word under the cursor or the visual selection.
"
" Vim's default behavior is to just extend the visual selection to the next
" word that matches the word under the cursor.  Doesn't seem very useful.
