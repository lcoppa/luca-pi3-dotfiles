""""""""""""""""""""""
" Init
""""""""""""""""""""""
set nocompatible               " Use Vim defaults instead of 100% vi compatibility
filetype off                   " Disable before plugins: required!


""""""""""""""""""""""
" Set plugin manager, choose one or the other
""""""""""""""""""""""
"
" 1) vundle plugin manager setup
"
"set rtp+=~/.vim/bundle/vundle/
"call vundle#rc()
"Bundle 'gmarik/vundle' 

""
" Plugins for Vundle
""

"
" github repos
"
"Bundle 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
"Bundle 'scrooloose/nerdtree'
"Bundle 'klen/python-mode'
"Bundle 'davidhalter/jedi-vim'
"
" vim-scripts repos
"

"
" non github repos
"




"
" 2) pathogen plugin manager setup
"
execute pathogen#infect()
call pathogen#incubate()
call pathogen#helptags()

""""""""""""""""""""""""
" plugins configuration
""""""""""""""""""""""""
filetype plugin on          " use the file type plugins
filetype plugin indent on   " required by many plugins!
syntax on                   " syntax highlighting

"
" POWERLINE setup
"
set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 9
set laststatus=2
set t_Co=256
let g:Powerline_symbols = 'fancy'

"
" PYTHON-MODE setup
"
" Activate rope
" Keys:
" K             Show python docs
" <Ctrl-Space>  Rope autocomplete
" <Ctrl-c>rr    Rope refactor rename token
" <Ctrl-c>g     Rope goto definition
" <Ctrl-c>d     Rope show documentation
" <Ctrl-c>f     Rope find occurrences
" <Leader>b     Set, unset breakpoint (g:pymode_breakpoint enabled)
" [[            Jump on previous class or function (normal, visual, operator modes)
" ]]            Jump on next class or function (normal, visual, operator modes)
" [M            Jump on previous class or method (normal, visual, operator modes)
" ]M            Jump on next class or method (normal, visual, operator modes)
"let g:pymode_rope = 1
" Documentation
"let g:pymode_doc = 1
"let g:pymode_doc_key = 'K'
" Linting; disable if using vim-jedi
"let g:pymode_lint = 0
let g:pymode_lint_checker = "pyflakes,pep8"
" Do NOT auto check on save, it's too slow on the Pi; use F5 
let g:pymode_lint_write = 0
map <F5> :PyLint<CR>
 " Support virtualenv
"let g:pymode_virtualenv = 1
" Enable breakpoints plugin
"let g:pymode_breakpoint = 1
"let g:pymode_breakpoint_key = '<leader>b'
" syntax highlighting
"let g:pymode_syntax = 1
"let g:pymode_syntax_all = 1
"let g:pymode_syntax_indent_errors = g:pymode_syntax_all
"let g:pymode_syntax_space_errors = g:pymode_syntax_all
" Don't autofold code
"let g:pymode_folding = 0

" Use to rename refactoring, which is <c-c>rr by default
map <F2> :RopeRename<CR>

"
" NERDTREE setup
"
" F2 was the default to opens sidedrawer
" we use F3
map <F3> :NERDTreeToggle<CR>

" 
" Fugitive
"
" It's a GIT plugin. I haven't tryed using it yet


"
" TASKLIST setup
"
"map <leader>td <Plug>TaskList

"
" SUPERTAB setup (code completion)
"
"au FileType python set omnifunc=pythoncomplete#Complete
"let g:SuperTabDefaultCompletionType = "context"
"set completeopt=menuone,longest,preview

"
" FLAKE8 setup
" 
" autorun flakes8 on save for python files
"autocmd BufWritePost *.py call Flake8()


"
" ULTISNIPS
"
" defaults are
"g:UltiSnipsExpandTrigger               <tab>
"g:UltiSnipsListSnippets                <c-tab>
"g:UltiSnipsJumpForwardTrigger          <c-j>
"g:UltiSnipsJumpBackwardTrigger         <c-k>
" but we emulate Textmate behaviour
"let g:UltiSnipsExpandTrigger="<tab>"
"let g:UltiSnipsJumpForwardTrigger="<tab>" 
"let g:UltiSnipsJumpBackwardTrigger="<s-tab>"



"
" VIM-MULTICURSOR
"
" To use: <c-m>, then select the text you want, then <v> to go back to 
" normal mode, then <i> or other insert commands, then type, then <esc>
" 
"
" Default mapping
" let g:multi_cursor_next_key='<C-n>'
" let g:multi_cursor_prev_key='<C-p>'
" let g:multi_cursor_skip_key='<C-x>'
" let g:multi_cursor_quit_key='<Esc>'
" Since I use <C-n> to remove the search highlight (see below)
" I will use <C-m> as start/next key
let g:multi_cursor_next_key='<C-m>'
let g:multi_cursor_start_key='<C-m>'

""""""""""""""""""""""""
" misc config
"
" NOTE FOR MACROS STRINGS: to enter the string equivalent of a special key or
" sequence (=enter, esc, <c-...>, etc) just type <c-v> then the key
""""""""""""""""""""""""

" macro 1: move a #-style comment at the last part of the current line, to the line above
" 
" ^     go to first char of line 
" /#    search for hash (this moves the cursor there)
"     <enter> (i.e. do the search)
" d$    cut from the hash to the EOL
" O     inser a new empty line above our line (this enters insert mode)
" ^]    <esc> (go back to normal mode)
" p     paste the comment (the indent level shoud be set automatically)
" j     move down to our line
" ^     go to first char of our line
" ^A    <c-a> remove trailing space (this nmap is set below)
let @a='^/#d$O#p^dlj^k^'
" run the macro above on the selected lines in visual mode
"vmap <leader>a :'<,'> normal @a

" macro 2: move a 1-line #-style comment right above the relevant code, at the end of the
" line of code itself
" :noh  un-highlight search highlighs left by /#
let @e='^d$j$a 	pkdd^/#:noh'
" run the macro above on the selected lines in visual mode
"vmap <leader>e :'<,'> normal @e

" make <c-a> remove trailing whitespace from current line
nmap <c-a> :s/\s\+$//<CR>

" code folding
set foldmethod=indent
set foldlevel=99

" set a restriction to line width for python files
"augroup vimrc_autocmds
"    autocmd!
"    " highlight characters in black past column 120
"    autocmd FileType python highlight Excess ctermbg=DarkGrey guibg=Black
"    autocmd FileType python match Excess /\%120v.*/
"    autocmd FileType python set nowrap
"augroup END

" window splits navigation: rebind to ctrl+arrow keys
map <c-j> <c-w>j
map <c-j> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" Use <leader>l to toggle display of whitespace
nmap <leader>l :set list!<CR>
" And set some nice chars to do it with
set listchars=tab:»\ ,eol:¬
" automatically change window's cwd to file's dir
set autochdir
" more subtle popup colors
if has ('gui_running')
    highlight Pmenu guibg=#cccccc gui=bold
endif


" make w!! able to save using sudo (asks for a pwd when saving)
ca w!! w !sudo tee "%"

set backspace=2         " more powerful backspacing
set ai                  " auto indenting
set history=100         " keep 100 lines of history
set ruler               " show the cursor position
" Show line numbers and length
set number              " show line numbers
set tw=79               " width of doc
set nowrap              " don't automatically wrap on load
set colorcolumn=80
highlight ColorColumn ctermbg=233
"set fo-=t               " dont' automatically wrap on typing
" highlight and make search case insensitive
set hlsearch            " highlight the last searched term
set incsearch
set ignorecase
set smartcase
" good python tabbing
set tabstop=4           " set tab width to 4
set shiftwidth=4
set softtabstop=4
set shiftround
set expandtab           " expand tabs to spaces

"""""""""""""""""""""""""""""
" From youtube
" http://www.youtube.com/watch?v=YhqsjUUHj6g&list=FL9Ka9NTP1DApyIx10JDn0Pg&index=1
"""""""""""""""""""""""""""""
" automatic .vimrc reload
autocmd BufWritePost .vimrc source %
" better clipboard
set clipboard=unnamed
" remove search highlights; this conflicts with vim-multi-cursor
noremap <c-n> :nohl<CR>
vnoremap <c-n> :nohl<CR>
noremap <c-n> :nohl<CR>
" map sort function to a key
vnoremap <Leader>s :sort<CR>
" by default vim saves swaps and a backup copy of the file at every save; this is slow on the pi
set nobackup
set nowritebackup
set noswapfile

" some option useful with slow terminals. See :help slow-terminal for info
"set ttyfast
set nowrap
set scrolljump=5
" disable parens matching, it's too slow on the Pi
let g:loaded_matchparen=1


" When editing a file, always jump to the last cursor position
autocmd BufReadPost *
\ if ! exists("g:leave_my_cursor_position_alone") |
\ if line("'\"") > 0 && line ("'\"") <= line("$") |
\ exe "normal g'\"" |
\ endif |
\ endif
