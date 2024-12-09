let s:p = copy(g:lightline#colorscheme#powerlineish#palette)

" Set custom lightline colors here.  For example:
"   let s:p.normal.middle = [ ['white', 'gray0'] ]
"
" For a real example, see
" https://github.com/itchyny/lightline.vim/blob/master/autoload/lightline/colorscheme/powerline.vim
let s:p.normal.left = [ ['darkestgreen', 'brightgreen', 'bold'], ['gray9', 'NONE'] ]
let s:p.normal.middle = [ ['white', 'NONE'] ]
let s:p.normal.right = [ ['gray10', 'gray2'], ['gray8', 'gray1'], ['gray6', 'gray0'] ]
let s:p.replace.left = [ ['white', 'brightred', 'bold'], ['brightred', 'NONE'] ]
let s:p.visual.left = [ ['black', 'brightestorange', 'bold'], ['brightestorange', 'NONE'] ]

let g:lightline#colorscheme#fiqbal_powerlineish#palette = lightline#colorscheme#fill(s:p)
