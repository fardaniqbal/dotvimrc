" Fardan's ~/.vim/gvimrc
set guioptions-=T " hide toolbar
set guioptions-=r " hide scrollbar
set lines=40
set columns=90

if has("win32")
  set gfn=ProFontWindows:h9,ProFont:h8
else
  set gfn=ProFont:h8,ProFontWindows:h9
endif

" Disable bold fonts in GUI.  From http://www.pixelbeat.org/settings/.gvimrc
" Originally written by Steve Hall
" See :help attr-list for possible attrs to pass
function! Highlight_remove_attr(attr)
    " save selection registers
    new
    silent! put

    " get current highlight configuration
    redir @x
    silent! highlight
    redir END
    " open temp buffer
    new
    " paste in
    silent! put x

    " convert to vim syntax (from Mkcolorscheme.vim,
    "   http://vim.sourceforge.net/scripts/script.php?script_id=85)
    " delete empty,"links" and "cleared" lines
    silent! g/^$\| links \| cleared/d
    " join any lines wrapped by the highlight command output
    silent! %s/\n \+/ /
    " remove the xxx's
    silent! %s/ xxx / /
    " add highlight commands
    silent! %s/^/highlight /
    " protect spaces in some font names
    silent! %s/font=\(.*\)/font='\1'/

    " substitute bold with "NONE"
    execute 'silent! %s/' . a:attr . '\([\w,]*\)/NONE\1/geI'
    " yank entire buffer
    normal ggVG
    " copy
    silent! normal "xy
    " run
    execute @x

    " remove temp buffer
    bwipeout!

    " restore selection registers
    silent! normal ggVGy
    bwipeout!
endfunction
autocmd BufNewFile,BufRead * call Highlight_remove_attr("bold")
" Note adding ,Syntax above messes up the syntax loading
" See :help syntax-loading for more info

"highlight Pmenu guibg=yellow guifg=black
"highlight PmenuSel guibg=white guifg=black
