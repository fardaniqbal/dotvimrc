set background=dark
let g:challenger_deep_termcolors=16
runtime colors/challenger_deep.vim
hi Comment    ctermfg=8
hi LineNr     ctermbg=NONE
hi Operator   ctermfg=3     " e.g. for/while in C-like langs
hi Statement  ctermfg=3     " e.g. if/else in C-like langs
hi Type       ctermfg=3     " e.g. int/char/etc in C-like langs
hi PreProc    ctermfg=5
hi String     ctermfg=6
hi Special    ctermfg=10    " escape chars in strings
hi Constant   ctermfg=1
hi Number     ctermfg=1
hi Float      ctermfg=1
hi Boolean    ctermfg=1

hi MatchParen ctermfg=0     ctermbg=10
hi Visual     ctermfg=254   ctermbg=62  " selected text
hi IncSearch  ctermfg=0     ctermbg=11  " incremental search hilight
hi Search     ctermfg=0     ctermbg=13  " general search hilight
