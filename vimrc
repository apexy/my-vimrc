" -----------------------------------------------------------------------------  
" |                            VIM Settings                                   |
" |                   (see gvimrc for gui vim settings)                       |
" -----------------------------------------------------------------------------  

set nocompatible
set clipboard+=unnamed  " use clipboard register '*' for all y, d, c, p ops
let mapleader = ","

" Encoding ************************************************************************
set enc=utf-8
set fenc=utf-8 " default fileencoding
set fencs=ucs-bom,utf-8,gb18030,gbk,gb2312,cp936,big5,euc-jp,euc-kr,latin1
"set langmenu=zh_CN.UTF-8
"lang mes zh_CN.UTF-8

" Tabs ************************************************************************
set softtabstop=4
set shiftwidth=4
set tabstop=4
set expandtab
set sta " a <Tab> in an indent inserts 'shiftwidth' spaces


" Indenting ********************************************************************
set ai " Automatically set the indent of a new line (local to buffer)
set si " smartindent	(local to buffer)


" Scrollbars ******************************************************************
set sidescrolloff=2
set numberwidth=4


" Windows *********************************************************************
set equalalways " Multiple windows, when created, are equal in size
set splitbelow splitright


" Cursor highlights ***********************************************************
"set cursorline
"set cursorcolumn


" Searching *******************************************************************
"set hlsearch  " highlight search
set incsearch  " incremental search, search as you type
"set ignorecase " Ignore case when searching 
set smartcase " Ignore case when searching lowercase
" Cleans the search hightlights
nmap <silent> <F5> :set invhlsearch<CR> 

" Colors **********************************************************************
"set t_Co=256 " 256 colors
set background=dark 
syntax on " syntax highlighting
colorscheme vj


" Status Line *****************************************************************
set showcmd
set ruler " Show ruler
set laststatus=2 " Show status line
set statusline=%<%f\ %h%m%r%=%k[%{&ff}][%{(&fenc==\"\")?&enc:&fenc}%{(&bomb?\",BOM\":\"\")}]\ %-14.(%l,%c%V%)\ %P
"set ch=2 " Make command line two lines high


" Line Wrapping ***************************************************************
"set nowrap
set wrap
set linebreak  " Wrap at word

" Folding ***************************************************************
set foldenable          " turn on folding
set foldmethod=marker   " make folding indent sensitive
set foldlevel=100       " don't autofold anything, but can still fold manually
set foldopen -=search   " don't open folds when you search into them
set foldopen -=undo     " don't open folds when you undo stuff
" Autoclose folds, when moving out of them
set foldclose=all

" Directories *****************************************************************
let $VIMDATA  = $HOME.'/.vimdata'
let $VIMFILES = $HOME.'/.vim'

" Setup backup location and enable
"set backupdir=~/backup/vim
set backupdir=$VIMDATA/backup
set backup

" Set Swap directory
"set directory=~/backup/vim/swap
set directory=$VIMDATA/temp

" Sets path to directory buffer was loaded from
autocmd BufEnter * lcd %:p:h


" File Stuff ******************************************************************
filetype plugin indent on
" To show current filetype use: set filetype

autocmd FileType html :set filetype=xhtml " we couldn't care less about html


" Inser New Line **************************************************************
map <S-Enter> O<ESC> " awesome, inserts new line without going into insert mode
map <Enter> o<ESC>
set fo-=r " do not insert a comment leader after an enter, (no work, fix!!)


" Sessions ********************************************************************
" Sets what is saved when you save a session
set sessionoptions=blank,buffers,curdir,folds,help,resize,tabpages,winsize


" Buffers ********************************************************************
set hidden  " allow to change buffer without saving
map <Leader>bf <ESC>:ls<CR>
map <left> <ESC>:bN<CR>
map <right> <ESC>:bn<CR>


" Tab Page ********************************************************************
map tn <ESC>:tabnew<CR>
map tc <ESC>:tabc<CR>


" Misc ************************************************************************
set backspace=indent,eol,start
set number " Show line numbers
set matchpairs+=<:>
set vb t_vb= " Turn off the bell, this could be more annoying, but I'm not sure how

" Set list Chars - for showing characters that are not
" normally displayed i.e. whitespace, tabs, EOL
"set listchars=trail:.,tab:>-,eol:$
"set nolist


" Mappings ********************************************************************
" Professor VIM says '87% of users prefer jj over esc', jj abrams strongly disagrees
imap jj <Esc>
imap uu _
"imap ,a @
"map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" map CTRL-L to piece-wise copying of the line above the current one
imap <C-L> @@@<ESC>hhkywjl?@@@<CR>P/@@@<CR>3s
" map ,f to display all lines with keyword under cursor and ask which one to jump to
nmap ,z [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>


" Mouse ***********************************************************************
"set mouse=a " Enable the mouse
"behave xterm
"set selectmode=mouse


" Cursor Movement *************************************************************
" Make cursor move by visual lines instead of file lines (when wrapping)
map <up> gk
map k gk
"imap <up> <C-o>gk
imap <up> <C-P>

map <down> gj
map j gj
"imap <down> <C-o>gj
imap <down> <C-N>

map E ge

map <Space> <C-F>
map <Leader><Space> <C-B>

" Rot13 encode the current file
map <F7>    ggVGg?

" abbrevs ******************************************************************
iab xtime <c-r>=strftime("%Y-%m-%d %H:%M:%S")<cr>
iab xdate <c-r>=strftime("%Y-%m-%d")<cr>
iab apexc <c-r>="[".strftime("%Y-%m-%d")." Apex(Crest)]"<cr>


" Omni Completion *************************************************************
autocmd FileType html :set omnifunc=htmlcomplete#CompleteTags
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete " may require ruby compiled in

" Templates *************************************************************
autocmd BufNewFile * silent! 0r $VIMDATA/templates/%:e.tpl


" -----------------------------------------------------------------------------  
" |                              Pluggins                                     |
" -----------------------------------------------------------------------------  

" Fuzzyfinder *****************************************************************
" Fuzzy finder rocks, like Command-T in TextMate (buggy at moment, fix!!)
"
let g:fuf_modesDisable = []
let g:fuf_abbrevMap = {
    \   '^vr:' : map(filter(split(&runtimepath, ','), 'v:val !~ "after$"'), 'v:val . ''/**/'''),
    \   '^m0:' : [ '/mnt/d/0/', '/mnt/j/0/' ],
    \ }
let g:fuf_file_exclude = '\v\~$|\.o$|\.git/|\.svn|\.DS_Store|\.exe$|\.bak$|\.swp$|((^|[/\\])\.[/\\]$)'
let g:fuf_mrufile_maxItem = 300
let g:fuf_mrucmd_maxItem = 400

nnoremap ,f :FufFile<CR>
nnoremap ,b :FufBuffer<CR>
nnoremap ,m :FufMruFile<CR>
nnoremap ,mc :FufMruCmd<CR>
nnoremap ,bb :FufBookmark<CR>

"nnoremap <silent> <C-n>      :FufBuffer<CR>
"nnoremap <silent> <C-p>      :FufFileWithCurrentBufferDir<CR>
"nnoremap <silent> <C-f><C-p> :FufFileWithFullCwd<CR>
"nnoremap <silent> <C-f>p     :FufFile<CR>
"nnoremap <silent> <C-f><C-d> :FufDirWithCurrentBufferDir<CR>
"nnoremap <silent> <C-f>d     :FufDirWithFullCwd<CR>
"nnoremap <silent> <C-f>D     :FufDir<CR>
"nnoremap <silent> <C-j>      :FufMruFile<CR>
"nnoremap <silent> <C-k>      :FufMruCmd<CR>
"nnoremap <silent> <C-b>      :FufBookmark<CR>
"nnoremap <silent> <C-f><C-t> :FufTag<CR>
"nnoremap <silent> <C-f>t     :FufTag!<CR>
"noremap  <silent> g]         :FufTagWithCursorWord!<CR>
"nnoremap <silent> <C-f><C-f> :FufTaggedFile<CR>
"nnoremap <silent> <C-f><C-j> :FufJumpList<CR>
"nnoremap <silent> <C-f><C-g> :FufChangeList<CR>
"nnoremap <silent> <C-f><C-q> :FufQuickfix<CR>
"nnoremap <silent> <C-f><C-b> :FufAddBookmark<CR>
"vnoremap <silent> <C-f><C-b> :FufAddBookmarkAsSelectedText<CR>
"nnoremap <silent> <C-f><C-e> :FufEditInfo<CR>
"nnoremap <silent> <C-f><C-r> :FufRenewCache<CR>


" autocomplpop ***************************************************************
" complete option
"set complete=.,w,b,u,t,k
"let g:AutoComplPop_CompleteOption = '.,w,b,u,t,k'
set complete=.
let g:AutoComplPop_IgnoreCaseOption = 0
let g:AutoComplPop_BehaviorKeywordLength = 3
let g:AutoComplPop_MappingDriven = 1


" TabBar ***************************************************************
"let g:Tb_SplitBelow = 1
"let g:Tb_TabWrap = 1
"let g:Tb_MaxSize = 3

" MiniBuffer ***************************************************************
"let g:miniBufExplTabWrap = 1               " make tabs show complete (no broken on two lines)
let g:miniBufExplSplitBelow=0

" NERDTree ***************************************************************
nmap <Leader>nt :NERDTree<CR> 

" Calendar ***************************************************************
"-----------------------------------------------------------------------------
let g:calendar_diary = $VIMDATA.'/diary'   " where to store your diary
nmap <Leader>ca :CalendarH<CR>

" HTML ***************************************************************
let g:no_html_tab_mapping = 'yes'
let g:no_html_toolbar = 'yes'
let g:html_tag_case = 'l'
let g:html_default_charset = 'utf8'
let g:html_charset = 'utf-8'
let g:html_authorname  = 'Yuan'
let g:html_authoremail = 'apexy2007@gmail.com'
let g:html_template = $VIMDATA.'/templates/htmlt.tpl'

" SQLUtilities ***************************************************************
let g:sqlutil_load_default_maps = 0 
let g:sqlutil_align_comma = 1
let g:sqlutil_keyword_case = '\U'
let g:sqlutil_align_where = 1
let g:sqlutil_align_first_word = 1
vmap <Leader>fs :SQLUFormatter<CR>


" PERL-SUPPORT ***************************************************************
let g:Perl_AuthorName      = 'Yuan'     
let g:Perl_AuthorRef       = 'Mn'                         
let g:Perl_Email           = 'apexy2007@gmail.com'            
let g:Perl_Company         = ''    


" -----------------------------------------------------------------------------  
" |                             OS Specific                                   |
" |                      (GUI stuff goes in gvimrc)                           |
" -----------------------------------------------------------------------------  

" Mac *************************************************************************
"if has("mac") 
  "" 
"endif
 
" Windows *********************************************************************
"if has("gui_win32")
  "" 
"endif


