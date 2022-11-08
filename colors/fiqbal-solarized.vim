let g:solarized_termtrans=1
set background=dark
runtime colors/solarized.vim
hi CursorLineNr cterm=NONE gui=NONE ctermfg=12
hi MatchParen cterm=NONE ctermfg=black ctermbg=lightblue

" If using transparent background, make line number margin transparent too.
if g:solarized_termtrans != 0
  hi LineNr ctermfg=8 ctermbg=NONE guibg=NONE
endif
