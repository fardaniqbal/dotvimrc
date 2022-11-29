" Fardan's ~/.vim/vimrc
if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
  set fileencodings=utf-8,latin1
endif

set nocompatible        " be vim (incompatible with "standard" vi)
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
set ttimeout            " time out after pressing ESC
set ttimeoutlen=16      " be responsive when pressing ESC (milliseconds)
set modelines=0         " prevent modeline security vulnurability
set nomodeline

set expandtab     " use spaces, not tabs (<ctrl-v TAB> inserts a real tab)
set shiftwidth=2  " number of spaces to use for each step of indentation
set softtabstop=2 " number of spaces to insert when hitting TAB
set tabstop=8     " real tab characters will be displayed as this wide
set textwidth=0   " wrap text to this many chars with the gq command (75)

if v:version >= 900
  set wop=pum     " show completions in pop-up window
endif

if has('linebreak')
  set linebreak       " soft-wrap text at word boundaries
  set bri             " indent soft-wrapped lines to same level as BOL
  let &sbr='└─▶︎ '     " mark soft-wrapped lines with this string
endif

" Enable mouse only if we have decent terminal support for it.
if has('mouse_sgr')
  set mouse=nvi ttymouse=sgr  " nvi = hit ":" for terminal mouse selection
elseif has('mouse_xterm')
  set mouse=nvi ttymouse=xterm2
endif

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
