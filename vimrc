" Fardan's ~/.vim/vimrc
set nocompatible        " be vim (incompatible with "standard" vi)
set encoding=utf-8      " internal char representation, _not_ file encoding
set bs=indent,eol,start " allow backspacing over everything
set incsearch           " do incremental searching
set ignorecase          " ignore case in searches and tags...
set smartcase           " ...unless search query has upper-case chars
set history=200         " set maximum length of command line history
set hidden              " keep files open when switching to other files
set nobackup            " disable auto backups
set noswapfile          " disable swap files
set ruler               " always show cursor position
set number              " show line numbers in left margin
set scrolloff=0         " always show this many lines above/below cursor
set showcmd             " show incomplete commands in command line
set wildignorecase      " ignore case when TAB-completing file names
set wildmenu            " show matches for command line TAB-completion
set ttimeout            " time out after pressing ESC; see also ttimeoutlen
set laststatus=2        " always show statusline
set noshowmode          " unnecessary; lightline shows mode in statusline
set modelines=0         " prevent modeline security vulnurability
set nomodeline

" Be responsive when pressing ESC (milliseconds).  XXX: values near 16 ms
" (typical monitor refresh rate circa 2024) cause HeisenBUGs during Vim's
" startup under mintty/Windows (https://en.wikipedia.org/wiki/Heisenbug).
" Values >= 50 ms fix them.  TODO: figure out a better default than 16 ms.
set ttimeoutlen=50

set expandtab     " use spaces, not tabs (<ctrl-v TAB> inserts a real tab)
set shiftwidth=2  " number of spaces to use for each step of indentation
set softtabstop=2 " number of spaces to insert when hitting TAB
set tabstop=8     " real tab characters will be displayed as this wide
set copyindent    " use indents from existing line for new indents
set pi            " try to preserve existing indents on autoindent

" Hard-wrap to this many cols with `gq` (set to 75 for 80-column terminal
" minus 5-column line-number gutter, or 0 to disable auto hard-wrap).
set textwidth=0

if v:version >= 900
  set wop=pum     " show completions in pop-up window
endif

if has('linebreak')
  set linebreak       " soft-wrap text at word boundaries
  set bri             " indent soft-wrapped lines to same level as BOL
  let &sbr='└─▶︎ '     " mark soft-wrapped lines with this string
endif

" Set <space> as leader key.
nnoremap <SPACE> <Nop>
map <Space> <Leader>
map <Space> <LocalLeader>

" Enable mouse only if we have decent terminal support for it.
if 1
  set mouse=    " ...or just disable mouse entirely if it annoys you
elseif has('mouse_sgr')
  set mouse=nvi ttymouse=sgr  " nvi = hit ":" for terminal mouse selection
elseif has('mouse_xterm')
  set mouse=nvi ttymouse=xterm2
endif

" Ignore this section if running NeoVim.
if !has('nvim')
  " Mac OS's terminfo files don't declare italic escapes, so define them.
  if has('unix') && system('uname -s') == "Darwin\n"
    let &t_ZH="\e[3m"   " escape sequence for enabling italic
    let &t_ZR="\e[23m"  " escape sequence for disabling italic
  endif

  " If terminal supports colors or if running in a GUI.
  if &t_Co > 2 || has("gui_running")
    syntax on       " enable syntax highlighting
    set hlsearch    " highlight the last used search pattern
    "set cursorline " hilight current line; !!! spikes cpu !!!

    " Set up lightline.
    let g:lightline = {
      \   'colorscheme': 'fiqbal_powerlineish',
      \   'active': {
      \     'left': [ [ 'mode', 'paste' ], [ 'gitbranch' ],
      \               [ 'readonly', 'filename' ] ]
      \   },
      \   'component_function': {
      \     'gitbranch' : 'Lightline_GitBranch',
      \     'filename'  : 'Lightline_Filename'
      \   },
      \ }
    function! Lightline_Filename()
      let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
      return '⛬  ' . filename . (&modified ? ' [+]' : '')
    endfunction
    function! Lightline_GitBranch()
      let branch = gitbranch#name()
      return branch == "" ? "" : 'Ψ ' . branch
    endfunction
    " Use Unicode box-drawing glyphs, not ASCII (│, ╱, ╲ vs |, /, \).
    let g:lightline.subseparator = { 'left': '│', 'right': '│' }
    let g:lightline.separator = { 'left': ' ', 'right': '' }
    colorscheme fiqbal-challenger_deep
  endif

  " If compiled with autocommand support.
  if has("autocmd")
    filetype plugin indent on " detect filetype, lang-specific indenting
    augroup vimrcEx
      au!
      " When opening a file, jump to last known cursor position (if valid).
      autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif
    augroup END

    " Automatically go into insert mode for terminal windows
    augroup vimrcTerminal
      au!
      autocmd BufEnter,WinEnter *
        \ if &buftype == 'terminal' |
        \   exec 'normal! i' |
        \ endif
    augroup END
  else
    set autoindent  " always enable autoindent if compiled w/o autocmds
  endif

  " Use cscope if available.
  if has("cscope") && filereadable("/usr/bin/cscope")
    set csprg=/usr/bin/cscope
    set csto=0
    set cst
    set nocsverb
    if filereadable("cscope.out")
      cs add cscope.out   " add any database in current directory
    elseif $CSCOPE_DB != ""
      cs add $CSCOPE_DB   " else add database pointed to by environment
    endif
    set csverb
  endif

  " The default directory for swap files is incorrect on Windows.
  if has("win32")
    set dir=$TEMP
  endif
endif

" Custom key bindings.
nmap <leader>bn :bn<CR>
nmap <leader>bp :bp<CR>
nmap <leader>bd <Plug>Bclose
nmap <Bslash> :NERDTree<CR>
nmap <leader><Bslash> :NERDTreeFocus<CR>
tnoremap <Esc><Esc> <C-\><C-n>

" Make vim-tmux-navigator work in terminal mode.
tmap <silent> <C-h> <cmd>TmuxNavigateLeft<cr>
tmap <silent> <C-j> <cmd>TmuxNavigateDown<cr>
tmap <silent> <C-k> <cmd>TmuxNavigateUp<cr>
tmap <silent> <C-l> <cmd>TmuxNavigateRight<cr>
tmap <silent> <C-\> <cmd>TmuxNavigatePrevious<cr>

" NERDTree tweaks.
if v:version >= 900
  " Exit Vim if NERDTree is the only window remaining in the only tab.
  autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | call feedkeys(":quit\<CR>:\<BS>") | endif
  " Close the tab if NERDTree is the only window remaining in it.
  autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | call feedkeys(":quit\<CR>:\<BS>") | endif
else
  " Exit Vim if NERDTree is the only window remaining in the only tab.
  autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
  " Close the tab if NERDTree is the only window remaining in it.
  autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
endif

" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if winnr() == winnr('h') && bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

" Start NERDTree when Vim starts with a directory argument.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | NERDTreeFocus | endif

" Load local config if available.
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif
