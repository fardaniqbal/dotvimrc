let g:solarized_termtrans=1
set background=dark
runtime colors/solarized.vim
hi CursorLineNr cterm=NONE gui=NONE ctermfg=12
hi MatchParen cterm=NONE ctermfg=black ctermbg=lightblue
hi StatusLine cterm=bold ctermfg=6 ctermbg=8
hi StatusLineNC cterm=bold ctermfg=11 ctermbg=8

" Check if running in Mac OS's Terminal app.  NB: doing `has('mac')` won't
" detect Mac Terminal if running Vim on a non-Mac we SSH-d into from a Mac!
" Requires $SSH_CLIENT_TERM_PROGRAM to be set correctly on the host (can do
" this automatically, e.g. here https://github.com/fardaniqbal/dotbashrc)
if $TERM_PROGRAM =~ 'Apple_Terminal' ||
 \ $SSH_CLIENT_TERM_PROGRAM =~ 'Apple_Terminal'
  " Mac OS's terminal app does weird things with colors.
  hi Normal ctermfg=10 ctermbg=NONE
  hi LineNr ctermfg=8 ctermbg=NONE
  hi Comment cterm=NONE ctermfg=8 ctermbg=NONE
elseif g:solarized_termtrans != 0
  " If transparent background, make line number margin transparent too.
  hi LineNr ctermbg=NONE guibg=NONE
else
  hi Normal ctermfg=12 ctermbg=0
  hi LineNr ctermfg=10 ctermbg=8
endif
