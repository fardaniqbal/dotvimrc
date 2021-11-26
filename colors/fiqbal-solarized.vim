set background=dark
let g:solarized_termtrans=1
runtime colors/solarized.vim " FIXME: why doesn't this line work?
hi CursorLineNr cterm=NONE gui=NONE ctermfg=12
hi MatchParen cterm=NONE ctermfg=black ctermbg=lightblue

" If using transparent background, make line number margin transparent too.
if g:solarized_termtrans != 0
  hi LineNr ctermbg=NONE guibg=NONE
endif
