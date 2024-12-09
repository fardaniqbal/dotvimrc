" Should really be deepcopy(), but copy() is faster and we don't require
" deepcopy() semantics for this use case.
let s:p = copy(g:lightline#colorscheme#powerlineish#palette)

" Set custom lightline colors here.  For a real example, see
" https://github.com/itchyny/lightline.vim/blob/master/autoload/lightline/colorscheme/powerline.vim
let s:p.normal.left = [ ['white', 'darkestblue'], ['gray10', 'gray2'], ['white', 'NONE'] ]
let s:p.normal.middle = [ ['white', 'NONE'] ]
let s:p.normal.right = [ [ 'white', 'darkestblue' ], [ 'gray10', 'gray2' ], [ 'gray8', 'NONE' ] ]

let s:p.insert.left = [ ['darkestgreen', 'brightgreen', 'bold'], ['brightgreen', 'gray2'] ]
let s:p.insert.middle = [ ['white', 'NONE'] ]
let s:p.insert.right = [ ['darkestgreen', 'brightgreen'], ['brightgreen', 'gray2'], ['gray8', 'NONE'] ]

let s:p.visual.left = [ ['black', 'brightestorange', 'bold'], ['brightestorange', 'gray2'] ]
let s:p.visual.right = [ ['black', 'brightestorange'], ['brightestorange', 'gray2'], ['gray8', 'NONE'] ]

let s:p.replace.left = [ ['white', 'brightred', 'bold'], ['brightred', 'gray2'] ]
let s:p.replace.right = [ ['white', 'brightred'], ['brightred', 'gray2'], ['gray8', 'NONE'] ]

let g:lightline#colorscheme#fiqbal_powerlineish#palette = lightline#colorscheme#fill(s:p)
