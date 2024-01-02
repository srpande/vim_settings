syntax enable
"" clang-format.py is taken from compiler location. Make sure your compiler location is correct.
"" cscope.vim and taglist.vim moved to use pack vim package manager in .vim/pack/.....

set nocompatible              " be iMproved, required

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vundle -- not ussing vundle plugin manager, moved to using pack plugin
" manager effective vim 8+
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"filetype off                  " required
"
""set history=100
"
"" set the runtime path to include Vundle and initialize
""set rtp+=~/.vim/bundle/Vundle.vim
"set rtp+=~/.vim/bundle/vundle
"call vundle#rc()
"" alternatively, pass a path where Vundle should install plugins
""call vundle#begin('~/some/path/here')
"
"Bundle 'Rykka/riv.vim'
"Bundle 'Rykka/clickable.vim'
""Bundle 'majutsushi/tagbar'
""Bundle 'Yggdroot/indentLine'
""Bundle 'mbadran/headlights'
"
"" All of your Plugins must be added before the following line
"call vundle#end()            " required
"filetype plugin indent on    " required
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vundle
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set incsearch
set hlsearch
set smartcase                   " Do smart case search
set et
set ts=2
set sw=2
set autoindent
set smartindent


" always set the size of the partition of the window to be the same
set equalalways
set statusline=%<%f\ %h%m%r%=%-20.(line=%l,col=%c%V,totlin=%L%)\%h%m%r%=%-40(,bytval=0x%B,%n%Y%)\%P
set showcmd
set laststatus=2
set ss=1                        " Nice sidescroll
set siso=9                      " Even nicer sidescroll ;)
set foldenable                  " Display folds by default
set ignorecase                  " Ignore case-sensitive search
set viminfo='10,\"100,:20,%,n~/.viminfo
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

" print a red line at 80'th column in screen
" toggle colored right border after 80 chars
" This does not work in ubuntu for some reason
let s:color_column_old = 0
function s:ToggleColorColumn()
  set colorcolumn=81
  if s:color_column_old == 0
    let s:color_column_old = &colorcolumn
    windo let &colorcolumn = 0
  else
    windo let &colorcolumn=s:color_column_old
    jet s:color_column_old = 0
  endif
endfunction

"nnoremap <C-C> :call <SID>ToggleColorColumn()<CR>
"nnoremap <C-h> :call<SID>LongLineHLToggle()<cr>
nnoremap hl :call<SID>LongLineHLToggle()<cr>

hi OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%>81v/
fun! s:LongLineHLToggle()
 if !exists('w:longlinehl')
  let w:longlinehl = matchadd('ErrorMsg', '.\%>80v', 0)
  echo "Long lines highlighted"
 else
  call matchdelete(w:longlinehl)
  unl w:longlinehl
  echo "Long lines unhighlighted"
 endif
endfunction

   "always do vertical split
":set diffopt=filler,vertical
:map dfs :diffsplit

" map sp i<Space><Esc>
" set dictionary=dict
" one screen forward terherasfakjsdfa;lskjdfa;skljdfalksjdflkasjdfa
map ; 66j
map [ 66k
map , 
" one screen backword
map z 
" insert an empty space
"nnoremap s i<Space><Esc>
"nnoremap s i<Space><Esc>
":map s i<Space><Esc>

:map <C-E> <Esc>:Vexplore<CR>
:map <C-I> :set invlist<CR>
:map <C-n> :set invnumber<CR>
:map <C-l> :set list<CR>
":set list lcs=tab:\|\
"set indentLine_color_term = 239
"set indentLine_char = 'c'

:map <C-J> <C-W>j
:map <C-K> <C-W>k
:map <C-=> <C-W>=
:map <C-X> <C-W>_<C-W>\|

set wrap linebreak nolist
set nowrapscan
set switchbuf=split
set splitright
set completeopt=longest,menuone

"Do NOT use F1-F5 - they are used by screen. Chckout ~/.screenrc
nnoremap <silent> <F6> :TagbarToggle<CR>
nnoremap <silent> <F7>
             \ : if exists("syntax_on") <BAR>
             \    syntax off <BAR>
             \ else <BAR>
             \    syntax enable <BAR>
             \ endif<CR>
nnoremap <silent> <F8> :TlistToggle<CR>
nnoremap <silent> <F9> :wq!<CR>
nnoremap <silent> <F10> :q!<CR>
nnoremap <silent> <F11> :bp<CR>
nnoremap <silent> <F12> :bn<CR>
nnoremap <leader>s :w!

:map <C-@>0 <Esc>:call Addcscope ()<CR>

au BufRead,BufNewFile *.py set ts=4
au BufRead,BufNewFile *.py set sw=4

au BufRead,BufNewFile *.td     set filetype=tablegen
au BufRead,BufNewFile *.ll     set filetype=llvm
au BufRead,BufNewFile *.dmp set filetype=hexagon
"au BufRead,BufNewFile *.s set filetype=hexagon
au BufRead,BufNewFile *.s set ts=8

"Indent lines
:map <leader>d :IndentLinesDisable<CR>
:map <leader>e :IndentLinesEnable<CR>

"update opened file
:map <leader>u :checktime<CR>

:map <leader>0 :set paste<CR>

"remove all blank spaces at the end of the line
:map <leader>1 :%s/\s\+$//e

"only required temporarility
:map <leader>2 :s/]), (/]),<C-V><C-M>(/g

:map vds :vertical diffsplit

"From git to patch, replace ---a and ---b
":map <leader>c :s/^--- a\//--- /e|s/^+++ b\//+++ /e
:map <leader>ca :%s/^--- a\//--- /e
:map <leader>cb :%s/^+++ b\//+++ /e

"get clang-format from llvm-project/clang/tools/clang-format/clang-format.py

" default is python3
if has('python')
  map <C-I> :pyf /home/sirpande/compiler/llvm_tip/llvm-project/clang/tools/clang-format/clang-format.py<cr>
  imap <C-I> <c-o> :pyf /home/sirpande/compiler/llvm_tip/llvm-project/clang/tools/clang-format/clang-format.py<cr>
elseif has('python3')
  map <C-R> :py3f /home/sirpande/compiler/llvm_tip/llvm-project/clang/tools/clang-format/clang-format.py<cr>
endif

" no need for this  clang-format is not taken from actuall llvm-project
" and is called with Control-R -- see above
"map <C-@>9 <Esc>:call FormatFile() <CR>
" clang format
":function FormatFile()
":   let l:lines="all"
":   pyf /home/sirish/.vim/clang-format.py
":endfunction



" clang format
":map <leader>c :ClangFormatAutoEnable

let g:clang_format#style_options = {
            \ "AccessModifierOffset" : -4,
            \ "AllowShortIfStatementsOnASingleLine" : "true",
            \ "AlwaysBreakTemplateDeclarations" : "true",
            \ "Standard" : "C++11"}

" map to <Leader>cf in C++ code

autocmd FileType c,cc,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cc,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>

" if you install vim-operator-user
"autocmd FileType c,cpp,objc map <buffer><Leader>x <Plug>(operator-clang-format)
" Toggle auto formatting:
nmap <Leader>ct :ClangFormatAutoToggle<CR>

"various color schemes

" good for white bg
colorscheme delek

" good for black background
" colorscheme darkblue
" colorscheme koehler
" colorscheme desert
colorscheme desert

:map cob :colorscheme darkblue<CR>
:map cod :colorscheme desert<CR>
:map col :colorscheme delek<CR>
:map cof :colorscheme default<CR>
:map coe :colorscheme elflord<CR>
:map cok :colorscheme koehler<CR>

" gives you dark background
:map com :colorscheme murphy<CR>


" good for black background
" colorscheme koehler
" colorscheme elflord

" good for white backround
" colorscheme delek

" :map xml : substitute/ //g
"  == <C-V><C-M>
:map xml :s/ /<C-V><C-M>/g
:map qqq :.,$s/$/ \\/g

" Smart way to move between windows
" Short cut to <c-w><c-x> on a window
nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nmap <C-h> <C-W>h
nmap <C-l> <C-W>l

nmap lw1 1 <C-w>>
nmap lw5 5 <C-w>>
nmap lw10 10 <C-w>>
nmap lw15 15 <C-w>>
nmap lw20 20 <C-w>>

" Treat long lines as break lines (useful when moving around in them)
map j gj

" Move ^('use'.* -> line up and append to the previous line
":%g/^('use'.*/normal kJ
