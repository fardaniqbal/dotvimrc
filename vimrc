" Fardan's ~/.vim/vimrc
if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
  set fileencodings=utf-8,latin1
endif

set nocompatible        " be vim (incompatible with "standard" vi)
set bs=indent,eol,start " allow backspacing over everything
set incsearch           " do incremental searching
set history=200         " set maximum length of command line history
set hidden              " keep files open when switching to other files
set nobackup            " disable auto backups
set noswapfile          " disable swap files
set ruler               " always show cursor position
set number              " show line numbers in left margin
set wildignorecase      " ignore case when TAB-completing file names
set wildmenu            " show matches for command line TAB-completion
set ttimeout            " time out after pressing ESC
set ttimeoutlen=50      " be responsive when pressing ESC
set modelines=0         " prevent modeline security vulnurability
set nomodeline

set expandtab     " use spaces, not tabs (<ctrl-v TAB> inserts a real tab)
set shiftwidth=2  " number of spaces to use for each step of indentation
set softtabstop=2 " number of spaces to insert when hitting TAB
set tabstop=8     " real tab characters will be displayed as this wide
set textwidth=75  " wrap text to this many chars when using the gq command

" Enable mouse only if we have decent terminal support for it.
if has('mouse_sgr')
  set mouse=a ttymouse=sgr
elseif has('mouse_xterm')
  set mouse=a ttymouse=xterm2
endif

if &term=="xterm"
  set t_Co=16       " number of colors that the terminal supports
  set t_Sb=[4%dm  " escape sequence for setting background color
  set t_Sf=[3%dm  " escape sequence for setting foreground color
endif

" If terminal supports colors or if running in a GUI.
if &t_Co > 2 || has("gui_running")
  syntax on       " enable syntax highlighting
  set hlsearch    " highlight the last used search pattern
  set cursorline  " hilight current line
  set background=dark         " FIXME: should be in colors/<whatever>.vim,
  let g:solarized_termtrans=1 " but solarized colorscheme won't load from
  colorscheme solarized       " that file for some reason.
  colorscheme fiqbal-solarized
endif

" If compiled with autocommand support.
if has("autocmd")
  filetype plugin indent on " detect filetype, language-specific indenting
  augroup vimrcEx
    au!
    " When opening a file, jump to last known cursor position (if valid).
    autocmd BufReadPost *
      \ if line("'\"") > 1 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
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

" Load local config if available.
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif
