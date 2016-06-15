set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle
" required!
Plugin 'gmarik/Vundle.vim'

"
" My Bundles here:
"
" original repos on github
Plugin 'altercation/vim-colors-solarized'
Plugin 'tpope/vim-fugitive'
" ]n and [n jump to conflict section is awesome
Plugin 'tpope/vim-unimpaired'
Plugin 'airblade/vim-gitgutter'
" Plugin 'altercation/vim-colors-solarized'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'tomtom/tcomment_vim'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-surround'
" enhance surround.vim, . to repeat command
Plugin 'tpope/vim-repeat'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'bling/vim-airline'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'ervandew/supertab'
Plugin 'vim-scripts/ZoomWin'
Plugin 'mileszs/ack.vim'
Plugin 'nelstrom/vim-visual-star-search'
Plugin 'Raimondi/delimitMate'
Plugin 'hulufei/vim-indexed-search'
Plugin 'AndrewRadev/splitjoin.vim'
Plugin 'junegunn/vim-easy-align'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'mbbill/undotree'
" You have to install https://github.com/CodeFalling/fcitx-remote-for-osx
Plugin 'CodeFalling/fcitx-vim-osx'

" Front-end related
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'kchmck/vim-coffee-script'
Plugin 'groenewege/vim-less'
Plugin 'wavded/vim-stylus'
Plugin 'mattn/emmet-vim'
Plugin 'digitaltoad/vim-jade'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'rizzatti/dash.vim'
" Plugin 'lambdatoast/elm.vim'
Plugin 'ElmCast/elm-vim'

Plugin 'nathangrigg/vim-beancount'

Plugin 'evanmiller/nginx-vim-syntax'

" Tagbar(js)
" Plugin 'majutsushi/tagbar'
" Plugin 'marijnh/tern_for_vim'

" vim-snipmate
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'hulufei/vim-snippets'

" All of your Plugins must be added before the following line
call vundle#end()            " required

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Windows
" set backupdir=~/.vim/backups//,E:/hulufei/tmp/backup//
" set directory=~/.vim/swps//,E:/hulufei/tmp/swp//
" Centralize backups, swapfiles and undo history
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if has("persistent_undo")
    set undodir=~/.undodir/
    set undofile
    set undolevels=1000         " Maximum number of changes that can be undone
    set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
endif
" Webpack watch not work properly on `auto` set(ubuntu)
set backupcopy=yes

set clipboard=unnamed " yank and paste with the system clipboard
" A few options that just make things better
set encoding=utf-8 nobomb
set termencoding=utf-8
set scrolloff=3
set autoindent
set visualbell
set showmode
set showcmd
set wildmenu
set wildmode=list:longest
set cursorline
set ttyfast
set ruler
set laststatus=2
" Add the g flag to search/replace by default
set gdefault
" Don’t add empty newlines at the end of files
set binary
set noeol
" Respect modeline in files
set modeline
set modelines=4
" Enable per-directory .vimrc files and disable unsafe commands in them
set exrc
set secure
" Disable error bells
set noerrorbells
" Don’t reset cursor to start of line when moving around.
set nostartofline
" Show the filename in the window titlebar
set title
" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
set hlsearch
set autowrite		" Automatically save before commands like :next and :make
set hidden             " Hide buffers when they are abandoned
set mouse=a		" Enable mouse usage (all modes)

set softtabstop=4
"set expandtab
set tabstop=4
set shiftwidth=4
set nu
set foldmethod=indent
"5行以下不要折叠
set foldminlines=5

"These lines manage my line wrapping settings and also show a colored column
"at 85 characters
set wrap
set textwidth=79
set formatoptions=qrn1
set colorcolumn=85

"当 VIM 工作在 Unicode 状态时，遇到这些宽度不明的字符时，默认使用窄字符，这会导致
"中文的破折号“——”非常短，五角星★等符号只能显示一半。因此，我们需要设置 ambiwidth=double 来解决这个问题。
set ambiwidth=double

set sessionoptions+=resize

set iskeyword+=-

" Prevent strange backspace behaviour in mac terminal
set backspace=indent,eol,start

" Use relative line numbers, new in Vim 7.3
if exists("&relativenumber")
  set relativenumber
  au BufReadPost * set relativenumber
endif

"Use the tab key match bracket pairs. It's a hell of a lot easier to type <tab> than <%>
nnoremap <tab> %
vnoremap <tab> %
"Makes j and k work the way you expect instead of working in some archaic
"'movement by file line instead of screen line' fashion
nnoremap j gj
nnoremap k gk
"Quicker Escaping, note conflict when type 'jj' in insert mode
inoremap jj <ESC>

" Shortcut for NERDTree plugin
map <F2> :NERDTreeToggle<CR>
map <c-o> :NERDTreeFind<cr>
" map <F2> :NERDTreeToggle %<CR>
" map <F2> :Explore<CR>

" Change the <leader> key, <,> is easier to type than <\>
let mapleader = ","

" Nerd Tree
let NERDChristmasTree=0
let NERDTreeWinSize=30
let NERDTreeChDirMode=2
let NERDTreeIgnore=['\~$', '\.pyc$', '\.swp$']
" let NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$',  '\~$']
let NERDTreeShowBookmarks=1
" let NERDTreeWinPos = "right"

" tcomment
map <leader>cs :TCommentBlock<CR>

" Undotree
nnoremap <leader>u :UndotreeToggle<CR>
" if undotree is opened, it is likely one wants to interact with it.
let g:undotree_SetFocusWhenToggle=1

"Explore settings
let g:netrw_preview   = 1
let g:netrw_liststyle = 3
let g:netrw_winsize   = 30
let g:netrw_keepdir= 0
let g:netrw_altv = 1
let g:netrw_list_hide = '^\..*'

" settings for kien/rainbow_parentheses.vim
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]
let g:rbpt_max = 40
let g:rbpt_loadcmd_toggle = 0

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" Airline
set t_Co=256
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_left_sep = '▶'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.whitespace = 'Ξ'

" Strip trailing whitespace
map <leader><space> :FixWhitespace<cr>

"Key mapping for zen coding(emmet)
" autocmd FileType html,css EmmetInstall
" let g:user_emmet_mode = 'a'
" let g:user_emmet_install_global = 0
let g:user_emmet_expandabbr_key = '<c-e>'

"Enable Syntastic plugin
let g:syntastic_enable_signs=1
let g:syntastic_json_checkers = ['jsonlint']
let g:syntastic_javascript_checkers = ['eslint']

" JSX
let g:jsx_ext_required = 0

" elm
let g:elm_format_autosave = 1

" ctrlp config
" exclude directories or files from the search
" MacOSX/Linux
set wildignore+=*/tmp/*,*.so,*.o,*.a,*.obj,*.swp,*.zip,*.pyc,*.pyo,*.class,.DS_Store
" Windows
" set wildignore+=tmp\*,*.swp,*.zip,*.exe,*.pyc
let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$\|node_modules$'
let g:ctrlp_working_path_mode = 2
let g:ctrlp_match_window = 'order:ttb,max:20'
" Ignore files in .gitignore
" let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" Vim-indent
let g:indent_guides_guide_size=1

" Source the vimrc file after saving it
if has("autocmd")
  autocmd! bufwritepost .vimrc source $MYVIMRC
endif
nmap <leader>v :tabedit $MYVIMRC<CR>

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>
" Use the same symbols as TextMate for tabstops and EOLs
" Show “invisible” characters
"set listchars=tab:▸\ ,trail:·,eol:¬,nbsp:_
set lcs=tab:▸\ ,eol:¬,nbsp:_

" Keybindings for plugin toggle
nmap <F4> :IndentGuidesToggle<cr>
nnoremap <leader>a :Ack

" splitjoin
nmap sj :SplitjoinSplit<cr>
nmap sk :SplitjoinJoin<cr>

" Format JSON
nmap =j :%!python -m json.tool<CR>

" Insert current date(YYYY-MM-DD)
" http://vim.wikia.com/wiki/Insert_current_date_or_time
nnoremap <leader>dts "=strftime("%F")<CR>P
inoremap <leader>dts <C-R>=strftime("%F")<CR>

"------------------
" Useful Functions
"------------------
" eggcache vim
nnoremap ; :
" w!! to sudo & write a file
cmap w!! w !sudo tee >/dev/null %
" easier navigation between split windows
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
" Repalce current words with yanked content
nnoremap <leader>p viw p
" Ctrlp shortcuts
nmap <leader>b :CtrlPBuffer<CR>

" If you want `n` to always search forward and `N` backward
nnoremap <expr> n  'Nn'[v:searchforward]
nnoremap <expr> N  'nN'[v:searchforward]

" Don't lose selection when shifting sidewards(you can use `gv` to reselect the last
" selection)
" Disabled, because break undo. Use `.` to repeat, `gv` to reselect
" xnoremap <  <gv
" xnoremap >  >gv

"By default Vim doesn't fold Javascript files,but you can add some
"basic,perfectly serviceable folding with these two lines in your .vimrc
au FileType javascript setlocal foldmethod=marker
au FileType javascript setlocal foldmarker={,}
" markdown file type
au BufRead,BufNewFile *.{md,markdown} set filetype=markdown
" Disable auto wrap in markdown file
" autocmd BufNewFile,BufRead *.{md,markdown} set nowrap
" Treat .json files as .js
autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
" Treat .ejs files as .html
autocmd BufNewFile,BufRead *.ejs set filetype=html
" automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =
" Autosave
" au InsertLeave <buffer> write

" Beancount
let g:beancount_detailed_first = 1
autocmd FileType beancount nnoremap <buffer> <leader>= :AlignCommodity<CR>
autocmd FileType beancount inoremap <c-f> <c-x><c-o>

" Return indent (all whitespace at start of a line), converted from
" tabs to spaces if what = 1, or from spaces to tabs otherwise.
" When converting to tabs, result has no redundant spaces.
function! Indenting(indent, what, cols)
  let spccol = repeat(' ', a:cols)
  let result = substitute(a:indent, spccol, '\t', 'g')
  let result = substitute(result, ' \+\ze\t', '', 'g')
  if a:what == 1
    let result = substitute(result, '\t', spccol, 'g')
  endif
  return result
endfunction

" Convert whitespace used for indenting (before first non-whitespace).
" what = 0 (convert spaces to tabs), or 1 (convert tabs to spaces).
" cols = string with number of columns per tab, or empty to use 'tabstop'.
" The cursor position is restored, but the cursor will be in a different
" column when the number of characters in the indent of the line is changed.
function! IndentConvert(line1, line2, what, cols)
  let savepos = getpos('.')
  let cols = empty(a:cols) ? &tabstop : a:cols
  execute a:line1 . ',' . a:line2 . 's/^\s\+/\=Indenting(submatch(0), a:what, cols)/e'
  call histdel('search', -1)
  call setpos('.', savepos)
endfunction
command! -nargs=? -range=% Space2Tab call IndentConvert(<line1>,<line2>,0,<q-args>)
command! -nargs=? -range=% Tab2Space call IndentConvert(<line1>,<line2>,1,<q-args>)
command! -nargs=? -range=% RetabIndent call IndentConvert(<line1>,<line2>,&et,<q-args>)

" vertical line ruler
map ,ch :call SetColorColumn()<CR>
function! SetColorColumn()
  let col_num = virtcol(".")
  let cc_list = split(&cc, ',')
  if count(cc_list, string(col_num)) <= 0
    execute "set cc+=".col_num
  else
    execute "set cc-=".col_num
  endif
endfunction

" Save a file as root (,W)
noremap <leader>W :w !sudo tee % > /dev/null<CR>

" Set tabstop, softtabstop and shiftwidth to the same value
command! -nargs=* Stab call Stab()
function! Stab()
  let l:tabstop = 1 * input('set tabstop = softtabstop = shiftwidth = ')
  if l:tabstop > 0
    let &l:sts = l:tabstop
    let &l:ts = l:tabstop
    let &l:sw = l:tabstop
  endif
  call SummarizeTabs()
endfunction

function! SummarizeTabs()
  try
    echohl ModeMsg
    echon 'tabstop='.&l:ts
    echon ' shiftwidth='.&l:sw
    echon ' softtabstop='.&l:sts
    if &l:et
      echon ' expandtab'
    else
      echon ' noexpandtab'
    endif
  finally
    echohl None
  endtry
endfunction

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  let g:ackprg = 'ag --nogroup --nocolor --column'

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" Copy current buffer path relative to root of VIM session to system clipboard
nnoremap <Leader>yp :let @*=expand("%")<cr>:echo "Copied file path to clipboard"<cr>
" Copy current filename to system clipboard
nnoremap <Leader>yf :let @*=expand("%:t")<cr>:echo "Copied file name to clipboard"<cr>
" Copy current buffer path without filename to system clipboard
nnoremap <Leader>yd :let @*=expand("%:h")<cr>:echo "Copied file directory to clipboard"<cr>

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" Why is VIM not detecting my coffescript filetype?
" The solution is to move syntax enable to the bottom of vimrc.
" http://goo.gl/E98yYi
syntax enable
filetype plugin indent on

" Go crazy!
if filereadable(expand("~/.vimrc.local"))
  " In your .vimrc.local, you might like:
  "
  " set autowrite
  " set nocursorline
  " set nowritebackup
  " set whichwrap+=<,>,h,l,[,] " Wrap arrow keys between lines
  "
  " autocmd! bufwritepost .vimrc source ~/.vimrc
  " noremap! jj <ESC>
  source ~/.vimrc.local
endif

set background=dark
" colorscheme solarized

" Vim diff colorscheme
" Another trick: `:syntax off` in diff
" highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
" highlight DiffDelete cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
" highlight DiffChange cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
" highlight DiffText   cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red

" highlight Normal term=none cterm=none ctermfg=White ctermbg=Black gui=none guifg=White guibg=Black
highlight DiffAdd cterm=none ctermfg=White ctermbg=Blue gui=none guifg=White guibg=Blue
highlight DiffDelete cterm=none ctermfg=White ctermbg=Blue gui=none guifg=White guibg=Blue
highlight DiffChange cterm=none ctermfg=White ctermbg=Blue gui=none guifg=White guibg=Blue
highlight DiffText cterm=none ctermfg=Black ctermbg=White gui=none guifg=Black guibg=White