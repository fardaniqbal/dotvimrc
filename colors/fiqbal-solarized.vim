if !has('mac')                " Solarized's transparent background mode in
  let g:solarized_termtrans=1 " Terminal.app messes up the color contrast
endif
set background=dark
runtime colors/solarized.vim
hi CursorLineNr cterm=NONE gui=NONE ctermfg=12
hi MatchParen cterm=NONE ctermfg=black ctermbg=lightblue

if g:solarized_termtrans != 0
  " If transparent background, make line number margin transparent too.
  hi LineNr ctermbg=NONE guibg=NONE
else
  hi Normal ctermfg=12 ctermbg=0
  hi LineNr ctermfg=10 ctermbg=8
endif
