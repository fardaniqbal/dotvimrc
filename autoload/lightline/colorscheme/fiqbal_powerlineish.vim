let s:p = copy(g:lightline#colorscheme#powerlineish#palette)

" Set custom lightline colors here.  For example:
"   let s:p.normal.middle = [ [ 'white', 'gray0' ] ]
"
" For a real example, see
" https://github.com/itchyny/lightline.vim/blob/master/autoload/lightline/colorscheme/powerline.vim

let g:lightline#colorscheme#fiqbal_powerlineish#palette = lightline#colorscheme#fill(s:p)
