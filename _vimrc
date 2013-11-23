" set runtimepath+=c:\\tools\\vim\\vimfiles
" behave mswin
" from _vimrc - not sure what it does
set diffexpr=MyDiff()
function! MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  silent execute '!C:\tools\Vim\vim71\diff ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
endfunction

execute pathogen#infect()

" ----------------------------------------------------------------------------
" General settings
" ----------------------------------------------------------------------------
let mapleader=" "
syntax on                           " Switch on syntax highlighting.
set mousehide                       " Hide the mouse pointer while typing
set backspace=2                     " allow backspaceing over end of line and beginning of insert
set shiftwidth=4                    " columns are in intervals of 4 spaces
set softtabstop=4                   " Tabs should be set at 4 spaces
set expandtab                       " use spaces instead of tabs
set nohlsearch
"set cursorline                      " highlight the current line
set ignorecase                      " search case insensitive
set incsearch                       " search incrementally
set showmatch                       " Highlight matching braces, parens, brackets
runtime macros/matchit.vim          " % will cycle all sorts of delimiters now

set sessionoptions+=resize          " resize the vim window when restoring the session
set ch=3                            " Make command line 3 lines high
set textwidth=80                    " wrap line at 100
set columns=85
set lines=50                        " 50 lines in editor window
set ruler                           " always show where we are in the file
set showmode                        " indicate when we're in INSERT mode

set history=1000                    " Remember 1000 commands
set cpoptions=aABceFs               " Default editing commands - obscure and not worth worrying about
set wildchar=<tab>                  " set use TAB for keyword completion 
set wildmenu
"set wildmode=longest,list          " more like emacs file completion
set wildignore=*.obj,*.pyc,*.scc,*.tags    " don't match uninteresting files
set tagrelative                     " search for files in same directory as tags file
set autoindent                      " line up text with previous indent
set cinkeys=0{,0},:,!^F,o,O,e       " C language indentation
set cinkeys-=0#
set nrformats-=octal                " don't treat numbers with leading 0's as octal
set shellpipe=>%s\ 2>&1             " this helps with stderr redirection
set viminfo='20,\"50,h,rA:,rB:,!    " save global variables for used with recent file list
set backup
set backupdir=c:/temp/vimbackup
set hidden                          " buffers can changed without saving to disk

" if '=' is part of allowed file names, settings and c-x,c-f don't work as well, so pull it out.
set isfname-==

" For some reason, this doesn't default to "" like it should.  The default
" makes ctrl-f/b end visual mode.
set keymodel=

" prevent mousewheel from pasting
map <MiddleMouse> <Nop>
imap <MiddleMouse> <Nop>"

" use this function in abbreviations to remove the space
func! Eatchar(pat)
  let c = nr2char(getchar())
  return (c =~ a:pat) ? '' : c
endfunc

" ----------------------------------------------------------------------------
" VB
" ----------------------------------------------------------------------------
autocmd BufRead,BufNewFile *.cls,*.net,*.vb set syn=vb

" ----------------------------------------------------------------------------
" C++
" ----------------------------------------------------------------------------

" abbreviations
au BufNewFile,BufRead *.cpp,*.h,*.c,*.idl set cindent
au BufNewFile,BufRead *.cpp,*.h,*.c,*.idl iabbrev f- <Esc>:s/\([a-zA-Z:<>_0-9]\+\)\s\+\([a-zA-Z_0-9()->\[\]]\+\)\s*\%#/for\ (\1::const_iterator\ it=\2.begin();\ it\ !=\ \2.end();\ ++it)<CR>
au BufNewFile,BufRead *.cpp,*.h,*.c,*.idl iabbrev s- std::string
au BufNewFile,BufRead *.cpp,*.h,*.c,*.idl iabbrev vs- std::vector<std::string>
au BufNewFile,BufRead *.cpp,*.h,*.c,*.idl iabbrev vsin- std::vector<std::string> const\&
au BufNewFile,BufRead *.cpp,*.h,*.c,*.idl iabbrev sin- std::string const&
au BufNewFile,BufRead *.cpp,*.h,*.c,*.idl iabbrev std- using namespace std;
au BufNewFile,BufRead *.cpp,*.h,*.c,*.idl iabbrev v- <Esc>:s/\([a-zA-Z:<>_0-9]\+\)\s*\%#/std::vector<\1>/<CR>A
au BufNewFile,BufRead *.cpp,*.h,*.c,*.idl iabbrev vin- <Esc>:s/\([a-zA-Z:<>_0-9]\+\)\s*\%#/std::vector<\1>\ const\&/<CR>$i
au BufNewFile,BufRead *.cpp,*.c,*.h map  :call SwitchCH()<CR>
autocmd BufRead,BufNewFile *.cpp,*.h,*.c,*.cs :map <F7> :cd %:p:h<cr>:wall<cr>:make<bar>:cwin<CR>

" quick searches
au BufNewFile,BufRead *.cpp,*.h,*.c,*.idl nmap <Leader>ss :vimgrep! <cword> %:p:h\\*.h %:p:h\\*.cpp %:p:h\\*.idl %:p:h\\*.c<cr>:copen<cr>
au BufNewFile,BufRead *.cpp,*.h,*.c,*.idl vmap <Leader>ss y:vimgrep! <C-R>" %:p:h\\*.h %:p:h\\*.cpp %:p:h\\*.idl %:p:h\\*.c<cr>:copen<cr>

" tags and path
set tags=./tags,c:/platformtags,tags,./tags,c:/smartcard/tags
set path=./*,.

" make
set makeprg=mk.bat

" ----------------------------------------------------------------------------
" all text files
" ----------------------------------------------------------------------------
" Sadly, this doesn't work as well as I had hoped...
"au BufNewFile,BufRead *.txt :iabbrev === <C-R>=substitute(getline(line('.')-1), '.', '=', 'g')<cr>
"au BufNewFile,BufRead *.txt :iabbrev --- <C-R>=substitute(getline(line('.')-1), '.', '-', 'g')<cr>

" ----------------------------------------------------------------------------
" html/xml files
" ----------------------------------------------------------------------------
" press c-space to turn current word into a tag
au BufNewFile,BufRead *.html,*.xml :imap <silent> <c-space> <ESC>"_yiw:s/\(\%#\w\+\)/<\1><\/\1>/<cr><c-o><c-l>f>a

" ----------------------------------------------------------------------------
" notes file 
" ----------------------------------------------------------------------------
au BufNewFile,BufRead notes.txt :set foldexpr=getline(v:lnum+1)=~'^==='?'>1':'=' 
au BufNewFile,BufRead notes.txt :set foldtext=getline(v:foldstart) 
au BufNewFile,BufRead notes.txt :set foldmethod=expr

" ----------------------------------------------------------------------------
" pomodoro file 
" ----------------------------------------------------------------------------
au BufNewFile,BufRead pomodoro.txt :set foldexpr=getline(v:lnum+1)=~'^==='?'>1':'=' 
au BufNewFile,BufRead pomodoro.txt :set foldtext=getline(v:foldstart) 
au BufNewFile,BufRead pomodoro.txt :set foldmethod=expr

" ----------------------------------------------------------------------------
" Python
" ----------------------------------------------------------------------------
au BufNewFile,BufRead *.py,*.pyc map <F5> :silent !ipython -i "%"<cr>
au BufNewFile,BufRead *.py,*.pyc map <F6> :silent !python -i "%"<cr>
au BufRead,BufNewFile *.py,*.pyc map <F7> :silent !ipython "%"<cr>
au BufNewFile,BufRead *.py,*.pyc map <F10> :silent !ipython -i "%"<cr>
au BufNewFile,BufRead *.py,*.pyc nmap <Leader>ss :vimgrep! <cword> %:p:h\\*.py %:p:h\\*.pyw<cr>:copen<cr>
au BufNewFile,BufRead *.py,*.pyc vmap <Leader>ss y:vimgrep! <C-R> %:p:h\\*.py %:p:h\\*.pyw<cr>:copen<cr>
au BufNewFile,BufRead *.py,*.pyc :set path+=c:/tools/Python25/lib/**

" Highlight lines that are over 80 characters in length
au BufNewFile,BufRead *.py,*.pyc :highlight OverLength ctermbg=red ctermfg=white guibg=#592929
au BufNewFile,BufRead *.py,*.pyc :match OverLength /\%81v.\+/


" ----------------------------------------------------------------------------
" Java
" ----------------------------------------------------------------------------
autocmd BufRead *.java set include=^#\s*import
autocmd BufRead *.java set includeexpr=substitute(v:fname,'\\.','/','g')

" change 'gf' command to understand java 'import' instead of c 'include'
set suffixesadd=.java,.py,.pyw,.h,.hpp

" ----------------------------------------------------------------------------
" C#
" ----------------------------------------------------------------------------
autocmd BufRead *.cs set errorformat=\ %#%f(%l\\\,%c):\ %m
au BufNewFile,BufRead *.cs :highlight OverLength ctermbg=red ctermfg=white guibg=#592929
au BufNewFile,BufRead *.cs :match OverLength /\%81v.\+/

" ----------------------------------------------------------------------------
" Ledger
" ----------------------------------------------------------------------------
autocmd BufRead *.ledger set syntax=ledger
autocmd BufNewFile,BufRead *.ledger map <F5> :new +r!ledger\ -V\ -s\ -f\ "#:p"\ balance<cr>1Gzt:set buftype=nofile<cr>
autocmd BufNewFile,BufRead *.ledger map <F6> :new +r!ledger\ -V\ -f\ "#:p"\ register<cr>1Gzt:set buftype=nofile<cr>
autocmd BufNewFile,BufRead *.ledger map <F7> :new +r!ledger\ -V\ -f\ "#:p"\ register\ "bank\|cash\|credit.card"<cr>1Gzt:set buftype=nofile<cr>

" expenses
autocmd BufNewFile,BufRead *.ledger map <Leader>le :new +r!ledger\ -p\ \"this\ month\"\ --sort\ -T\ -s\ -V\ -f\ "#:p"\ balance\ expense<cr>1Gzt:set buftype=nofile<cr>
autocmd BufNewFile,BufRead *.ledger map <Leader>li :new +r!ledger\ -p\ \"this\ month\"\ --sort\ -T\ -s\ -V\ -f\ "#:p"\ balance\ "expense\|income"<cr>1Gzt:set buftype=nofile<cr>

" asset and liability balances
autocmd BufNewFile,BufRead *.ledger map <Leader>lb :new +r!ledger\ -V\ -s\ -f\ "#:p"\ balance\ "assets.bank\|assets.cash\|liabilities.credit"<cr>1Gzt:set buftype=nofile<cr>

" budget progress
autocmd BufNewFile,BufRead *.ledger map <Leader>lu :new +r!ledger\ --budget\ -V\ -s\ -f\ "#:p"\ balance\ expenses<cr>1Gzt:set buftype=nofile<cr>

" spending in the last month from common accounts
"autocmd BufNewFile,BufRead *.ledger map <Leader>ls :new +r!ledger\ -V\ -f\ "#:p"\ register\ "bank\|cash\|credit.card"<cr>1Gzt:set buftype=nofile<cr>
autocmd BufNewFile,BufRead *.ledger map <Leader>ls :new +r!ledger\ --wide\ -V\ -f\ "#:p"\ register<cr>:set buftype=nofile<cr>

" ----------------------------------------------------------------------------
" Global Key Mappings
" ----------------------------------------------------------------------------
map <F3> :e %:p:h<cr>
map <F4> :silent !explorer /e,%:p:h<cr>
map <F8> :cn<cr>
map <F9> :cprev<cr>
map <F11> :Tlist<cr>
map <Leader>mm :wall<cr>:set cmdheight=3<cr>:make<cr>:set cmdheight=2<cr>
map <Leader>mu :MRU<cr>
map <Leader>mr :MRU<cr>
map <Leader>rr :MRU<cr>

" ----------------------------------------------------------------------------
" Directory shortcuts
" ----------------------------------------------------------------------------
" change to directory of current file
map <Leader>cc :cd %:p:h<cr>:pwd<cr>

" change to desktop
map <Leader>cd :cd $USERPROFILE/Desktop<cr>:pwd<cr>

" change to My Documents
"map <Leader>cm :cd $USERPROFILE/My\ Documents<cr>:pwd<cr>
map <Leader>cm :cd $USERPROFILE/Documents<cr>:pwd<cr>

" edit directory of current file
map <Leader>ec :e %:p:h<cr>

" edit current directory
map <Leader>ee :e .<cr>

" open an explorer in the current directory
map <Leader>ex :silent !explorer /e,%:p:h<cr>

" edit desktop
map <Leader>ed :e $USERPROFILE/Desktop<cr>

" edit my documents
"map <Leader>em :e $USERPROFILE/My\ Documents<cr>
map <Leader>em :e $USERPROFILE/Documents<cr>

" ----------------------------------------------------------------------------
" Shortcuts to special files
" ----------------------------------------------------------------------------
" open pomodoro.txt
map <Leader>ep :e $USERPROFILE/Desktop/pomodoro.txt<cr>

" open notes.txt
map <Leader>en :e $USERPROFILE/Documents/Personal/notes.txt<cr>

" edit ledger
map <Leader>el :e $USERPROFILE/Documents/Personal/finances/wright.ledger<cr>

" open scratch.txt
map <Leader>es :e $USERPROFILE/Documents/scratch.txt<cr>

" open bookmarks.txt
map <Leader>eb :e $USERPROFILE/Documents/bookmarks.txt<cr>

" write to bookmarks.txt
map <Leader>bb :call Bookmark()<cr>

" open buffer explorer
map <Leader>bu :BufExplorer<cr>

map <c-space> /
imap <c-space> <esc>
imap kj <esc>
map <s-space> :
map <a-j> <c-w>j
map <a-k> <c-w>k
map <a-n> :bnext!<cr>
map <a-p> :bprev!<cr>
map <a-d> :bdelete<cr>
map <a-o> <c-w>o
map <c-down> ]]z.
map <c-up> [[z.

inoremap <m-d> <C-R>=strftime("%a %b %d %Y")<CR>
iabbrev dt- <C-R>=strftime("%a %b %d %Y")<CR>
iabbrev ul- <esc>kyyp:s/./-/g<cr>A
iabbrev ull- <esc>kyyp:s/./=/g<cr>A
iabbrev ulll- <esc>kyyppkk:s/./=/g<cr>jj:s/./=/g<cr>A
iabbrev tm- <C-R>=strftime("%X")<CR>
iabbrev dts- <C-R>=strftime("%y/%m/%d")<CR>
"iabbrev auth @author Mark Wright (mwright)
iabbrev cosnt const

map <Leader>ff :call ToggleIndentedFolding()<cr>

nmap <Leader>sa :Ack <cword><cr>
vmap <Leader>sa y:Ack <C-R>"<cr>

command! W w         " I always type :W instead of :w
command! Q q         " I always type :Q instead of :q
command! Qa qa         " I always type :Qa instead of :qa
command! E e         " I always type :Q instead of :q

" set up formatting options
set formatoptions=tcroq

" fold lines based on indentation
" set foldmethod=indent

" set user interface option
"set guifont=Fixedsys:h9:cANSI
set guifont=Droid_Sans_Mono:h10:cANSI
"set guifont=Anonymous:h9:cANSI
":colorscheme darkblue
":colorscheme tabula
"set guifont=Lucida_Console:h8:cANSI
:colorscheme desert
set guioptions=gmrLt
set cmdheight=2

" ======================================================================
" Templates for new files
" ======================================================================

" open vimfiles\skeleton files when creating new files
autocmd BufNewFile *.cpp 0r $VIM\vimfiles\skeleton\skeleton.cpp|call ReplaceYYYMMDDWithDate()|/return.0
autocmd BufNewFile *.cs 0r $VIM\vimfiles\skeleton\skeleton.cs|call ReplaceXXXWithFileName()|call ReplaceYYYMMDDWithDate()|/Mark
autocmd BufNewFile *.h 0r $VIM\vimfiles\skeleton\skeleton.h|call ReplaceXXXWithFileNameUpperCase()|call ReplaceYYYMMDDWithDate()|/Mark
autocmd BufNewFile setup.py 0r $VIM\vimfiles\skeleton\setup.py
autocmd BufNewFile *.py 0r $VIM\vimfiles\skeleton\skeleton.py
autocmd BufNewFile *.java 0r $VIM\vimfiles\skeleton\skeleton.java|call ReplaceXXXWithFileName()|call ReplaceYYYMMDDWithDate()
autocmd BufNewFile mk.bat 0r $VIM\vimfiles\skeleton\mk.bat

fun! ReplaceXXXWithFileName()
	exe "%s/XXX/" . expand("%:t:r") . "/" 
endfun

fun! ReplaceXXXWithFileNameUpperCase()
	exe "%s/XXX/" . toupper(expand("%:t:r")) . "/" 
endfun

fun! ReplaceYYYMMDDWithDate()
	exe "%s/YYYYMMDD/" . strftime("%Y-%m-%d") . "/" 
endfun

" ======================================================================
" Menu changes
" ======================================================================

" add a menu entry for inserting the date
amenu Edit.-fontsep- :<CR>
amenu Edit.Insert\ Date\ and\ Time :let abc="normal i" . strftime("%a %b %d %H:%M:%S %Y")<bar>:execute abc<CR>
amenu Edit.Insert\ Date :let abc="normal i" . strftime("%a %b %d %Y")<bar>:execute abc<CR>

" add a menu entry for changing to the current file's directory
amenu File.CD\ To\ File\ Dir :cd %:h<CR>

" add a menu entry for switching between cpp and header
amenu File.Switch\ \.c/\.h :call SwitchCH()<CR>

" add a menu entry for showing the current file's taglist
amenu Tools.-fontsep- :<CR>
amenu Tools.Tag\ list :Tlist<CR>

" create a window with CVS history for the current file, move to the history
" entry text and make the window a scratch window so you can delete it
amenu Tools.CVS\ History :new +r!cvs\ log\ #<CR>1G/^description<cr>zt:set buftype=nofile<cr>

" create a window with CVS difference for the current file, move to it
" and make the window a scratch window so you can delete it
amenu Tools.CVS\ Diff :new +r!cvs\ diff\ #<CR>1G:set buftype=nofile<cr>

" add a menu entries for small and large fonts
amenu Window.-fontsep- :<CR>
amenu Window.Large\ Font :set guifont=Fixedsys:h9:cANSI<CR>
amenu Window.Small\ Font :set guifont=Lucida_Console:h8:cANSI<CR>

" add a menu for known files
amenu Special\ Files.Notes :sp $USERPROFILE/Documents/notes.txt<cr>
amenu Special\ Files.vimrc :sp $VIM\_vimrc<CR>
amenu Special\ Files.Bookmarks :sp $USERPROFILE/Documents/bookmarks.txt<cr>
amenu Special\ Files.Desktop :sp $USERPROFILE\Desktop<cr>

" help stuff
amenu Help.-fontsep- :<CR>
amenu PopUp.CloseCurrentWindow :close<CR>

" ======================================================================
" Tag List Configuration
" ======================================================================
" let Tlist_Auto_Open = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_Compact_Format = 0
let Tlist_Use_Right_Window = 1
let Tlist_Show_One_File = 1
let Tlist_WinWidth = 50
let Tlist_Auto_Highlight_Tag = 1
let Tlist_Sort_Type = 'name'
let Tlist_Display_Tag_Scope = 1
" let winManagerWindowLayout = 'FileExplorer|TagList'

" ======================================================================
" File explorer Configuration
" ======================================================================
" when using the file explorer don't take up too much screen real-estate
let g:explWinSize=7

" open file explorer below
let g:explStartBelow=1    

" when using the file explorer don't unintersting files
let g:explHideFiles='\.pyc$,\.obj$,\.class$,\.swp$,\.lnk$,\.scc$,^tags$'
let g:netrw_list_hide='\.pyc$,\.obj$,\.class$,\.swp$,\.lnk$,\.scc$,^tags$'

" ======================================================================
" Calendar Configuration
" ======================================================================
let g:calendar_diary=$USERPROFILE . "\\Documents\\Personal\\Diary"

" ======================================================================
" NERD Explorer Configuration
" ======================================================================
let NERDTreeIgnore=['\.pyc$', '^tags$', '\.scc$', '^tags$']
let NERDTreeHijackNetrw=0

" ======================================================================
" NERD Explorer Configuration
" ======================================================================
set runtimepath^=c:/tools/ctrlp.vim

" ======================================================================
" Autoclose Configuration
" ======================================================================
" same as default, except without single parens, which I mostly use as
" punctuation...
let g:AutoClosePairs = {'(': ')', '{': '}', '[': ']', '"': '"'}

" ======================================================================
" a little function to add lines
" ======================================================================
fun! SumLines() range
    let sum = 0
    let line = a:firstline
    while line <= a:lastline
        let sum = sum + str2nr(getline(line))
        let line = line + 1
    endwhile
    call append(a:lastline, sum)
endfun

" ======================================================================
" Font Size
" ======================================================================
fun! BiggerFont() 
    let fontsize=substitute(&guifont, "^.*:h\\(\\d*\\):.*$", "\\1", "")
    echo fontsize
    let fontsize=fontsize+1
    if fontsize > 25
      let fontsize=6
    endif
    echo "New font size:" . string(fontsize)
    let &guifont = substitute(&guifont, "\\(^.*:h\\)\\(\\d*\\)\\(:.*$\\)", "\\1" . string(fontsize) . "\\3", "")
    echo &guifont
endfun
fun! SmallerFont() 
    let fontsize=substitute(&guifont, "^.*:h\\(\\d*\\):.*$", "\\1", "")
    let fontsize=fontsize-1
    if fontsize < 6
      let fontsize=25
    endif
    echo "New font size:" . string(fontsize)
    let &guifont = substitute(&guifont, "\\(^.*:h\\)\\(\\d*\\)\\(:.*$\\)", "\\1" . string(fontsize) . "\\3", "")
endfun

com! BiggerFont call BiggerFont()
com! SmallerFont call SmallerFont()
map <c-pageup> :call BiggerFont()<cr>
map <c-pagedown> :call SmallerFont()<cr>

" ======================================================================
" function to create a bookmark
" ======================================================================
function! Bookmark()
  :redir >> $USERPROFILE\\Documents\\bookmarks.txt
  :echo '# '. expand("%:t") . "                 - " . strftime("%Y-%b-%d %a %H:%M")
  :echo expand("%:p").' '.line('.')
  :redir END
endfunction                              
:command! Bookmark :call Bookmark()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  Create a static function above the current line.  If there is a
"  selection, move the lines selected into the new static function.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! MakeStatic(...) range
    let replaceSelection = 0
    let functionName = "TODO_function"
    if a:0 > 0
        let replaceSelection = a:1
    endif
    if a:0 > 1
        let functionName = a:2
    endif

    let functionContents = []
    if replaceSelection
        let functionContents = getbufline('%', a:firstline, a:lastline)
        execute(a:firstline . "," . a:lastline . "d")
    endif

    " put the function call in, mark it with 'f' and indent it
    call append(line(".")-1, functionName . "();")
    execute(a:firstline . "mark e")
    call cursor(a:firstline, 0)
    execute("normal ==")

    " go to the blank line above the current function
    call search("^{", "b")
    call search("^\\s*$", "b")

    " append function definition
    let newFunctionDefinition = ["static void ". functionName . "()", "{"] + functionContents + ["}", ""]
    call append(line("."), newFunctionDefinition)
    call search("^{")
    execute "normal mf"
    "reformat
    execute "normal va{="

    execute "normal 'e"
endfunction

nmap <Leader>mks :call MakeStatic(0)<cr>
vmap <Leader>mks :call MakeStatic(1)<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Add trailing slashes to all lines in range except the last.  The slashes
" are lined up on the right.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! MultilineDefine() range
    let slashCol = 80
    let firstline = a:firstline
    let lastline = a:lastline

    if firstline == lastline
        " search backwards until you find ^#define
        firstline = search('^\s*define', "bcW")
        lastline = search('^\s*$', "w")
    endif

    " strip trailing whitespace and any '\' characters
    execute(':' . string(firstline) . ',' . string(lastline) . 's/\s*\\\s*$')

    " get the length of the largest line 
    let maxLineLength = 0
    for curLine in getbufline('%', firstline, lastline)
        let maxLineLength = max([strlen(curLine), maxLineLength])
    endfor
    let slashCol = max([slashCol, maxLineLength + 1])

    " for all lines in selection except the last one, pad with spaces
    let curLine = firstline
    while curLine < lastline
        call cursor(curLine, 0)
        let curLineLen = strlen(getbufline('%', curLine)[0])
        execute('normal ' . string(slashCol - curLineLen) . 'A ')
        execute('normal A\')
        let curLine = curLine + 1
    endwhile 
endfunction
command! MultilineDefine :call MultilineDefine()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Function to create a ledger entry that updates the cash on hand value
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! UpdateCashBalance(ledger_file)

    let ledger_file = a:ledger_file

    " get new balance and convert into cents
    let new_bal_str = input("Enter new cash on hand balance:")
    if stridx(new_bal_str, ".") < 0
        let new_bal_cents = str2nr(new_bal_str) * 100
    else
        let new_bal_dollars_and_cents = split(new_bal_str, '\.')
        let new_bal_cents = str2nr(new_bal_dollars_and_cents[0]) * 100 + str2nr(new_bal_dollars_and_cents[1])
    endif

    " get current balance and convert into cents
    let cmd = 'ledger -f "' . ledger_file . '" balance cash'
    let result = split(system(cmd), "\n")[-1]
    let dollars_and_cents = split(substitute(result, '\$', "", ""), '\.')
    let cents = str2nr(dollars_and_cents[0]) * 100 + str2nr(dollars_and_cents[1])
    let adj = cents - new_bal_cents 

    " put an entry that will update the balance to the new balance
    let new_entry = [strftime("%Y/%m/%d") . " Balance Adjustment"]
    let new_entry += ["    Expenses:Dining                         $" .  printf("%d.%02d", adj / 100 , adj % 100)]
    let new_entry += ["    Assets:Cash"]
    call append(line("$"), new_entry)
endfunction

command! UpdateCashBalance :call UpdateCashBalance(eval("@%"))

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Function to surround current line in '='s
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
fun! TitleCurrentLine()
    let ln=line('.')
    let l=getline(ln)
    let l=substitute(l, ".", "=", "g")
    exe append(ln, l)
    exe append(ln-1, l)
    exe setpos(0, ln+1)
endfun

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Function to make nice python fold text
" TODO fix this
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
fun! PythonFoldText()
    let line=getline(v:foldstart)
    " first line in fold is triple-quoted comment - use next line
    if (line =~ '^\s*"""\s*$')
        let line=getline(v:foldstart+1)
    elseif ((line !~ '^\s*"') && (line !~ "^\\s*'"))
        let line="no doc string"
    endif
    let line=substitute(line, '^\s*', '', '')
    let line=substitute(line, '^"*', '', '')
    let line=substitute(line, "^'*", '', '')

    " pad or truncate the line as necessary to put number of folded
    " characters to the right
    let n = v:foldend - v:foldstart + 1
    let info = " (" . n . " lines)"
    let line = '> ' . line
    let max_width = winwidth(0) - len(info)
    if len(line) > maxwidth:
        let line = strpart(line, 0, maxwidth) + info
    else
        let line = line + info
    endif
    return line
endfun

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Function to toggle indented folding
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
fun! ToggleIndentedFolding()
    if &foldenable && &foldmethod == 'indent'
        echo "unfolding"
        set nofoldenable
    else
        echo "folding"
        set foldmethod=indent
        set foldenable
        execute("normal zM")
    endif
endfun

"set nocp
"filetype plugin on
"au GUIEnter * simalt ~x
