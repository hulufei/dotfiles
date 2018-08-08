" Change the <leader> key, <,> is easier to type than <\>
let mapleader = ","

call plug#begin('~/.local/share/nvim/plugged')

" Plug 'iCyMind/NeoSolarized'
Plug 'sheerun/vim-polyglot'
Plug 'trevordmiller/nova-vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'airblade/vim-gitgutter'

Plug 'Raimondi/delimitMate'
let delimitMate_expand_cr = 1

Plug 'bronson/vim-visual-star-search'
Plug 'henrik/vim-indexed-search'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-obsession'

Plug 'blindFS/vim-taskwarrior'
nnoremap <leader>t :tabnew <bar> :TW<CR>

Plug 'vimwiki/vimwiki', {'branch': 'dev'}
let wiki = {}
let wiki.path = '~/Dropbox/vimwiki'
let wiki.syntax = 'markdown'
let wiki.ext = '.md'
let wiki.auto_toc = 1
let wiki.nested_syntaxes = {'python': 'python', 'c++': 'cpp', 'reason': 'reason', 'javascript': 'javascript'}
let g:vimwiki_list = [wiki]
:map <Leader>tt <Plug>VimwikiToggleListItem
" <bar> chain commands
" :tcd set the current directory for the current tab and window.
" %:h the directory of the current file
:nmap <Leader>wt <Plug>VimwikiTabIndex <bar> :tcd %:h<cr>

" ]n and [n jump to conflict section is awesome
Plug 'tpope/vim-unimpaired'

Plug 'skywind3000/asyncrun.vim'
augroup asyncrun
  autocmd User AsyncRunStart call asyncrun#quickfix_toggle(8, 1)
augroup END
noremap <leader>q :call asyncrun#quickfix_toggle(8)<cr>
nnoremap <leader>e :AsyncRun

Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
" let g:airline_solarized_bg='dark'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#ale#enabled = 1

" Yank and paste a window with <leader>ww
Plug 'wesQ3/vim-windowswap'
" Conflict with vimwiki, disable it
let g:windowswap_map_keys=0

" Lint
Plug 'w0rp/ale'
nmap <silent> <leader>k <Plug>(ale_previous_wrap)
nmap <silent> <leader>j <Plug>(ale_next_wrap)
nmap <silent> <leader>x <Plug>(ale_fix)
" nnoremap <silent> gd :ALEGoToDefinition<cr>
" nnoremap <silent> <cr> :ALEHover<cr>
nnoremap <silent> gr :ALEFindReferences<cr>
" Enable completion where available.
" let g:ale_completion_enabled = 1
let g:ale_linters = {
\   'haskell': ['ghc-mod'],
\}
let g:ale_fixers = {
\   'javascript': ['prettier', 'eslint'],
\   'json': ['fixjson'],
\   'reason': ['refmt'],
\}
let g:ale_fix_on_save = 1

Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
map <c-o> :NERDTreeFind<cr>

Plug 'scrooloose/nerdcommenter'
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' }
Plug 'Twinside/vim-hoogle', { 'for': 'haskell' }
" Hoogle the word under the cursor
nnoremap <silent> <leader>hh :Hoogle<CR>
" Hoogle and prompt for input
nnoremap <leader>hH :Hoogle
" Hoogle for detailed documentation (e.g. "Functor")
nnoremap <silent> <leader>hi :HoogleInfo<CR>
" Hoogle for detailed documentation and prompt for input
nnoremap <leader>hI :HoogleInfo
" Hoogle, close the Hoogle window
nnoremap <silent> <leader>hz :HoogleClose<CR>

" to - Apply one hint at cursor position
" ta - Apply all suggestions in the file
" Require:
" stack install hlint apply-refact
Plug 'mpickering/hlint-refactor-vim', { 'for': 'haskell' }

" Required by ghcmod-vim
Plug 'Shougo/vimproc.vim', { 'do' : 'make' }
Plug 'eagletmt/ghcmod-vim', { 'for': 'haskell' }
map <silent> tw :GhcModTypeInsert<CR>
map <silent> ts :GhcModSplitFunCase<CR>
map <silent> tq :GhcModType<CR>
map <silent> te :GhcModTypeClear<CR>
Plug 'eagletmt/neco-ghc', { 'for': 'haskell' }
let g:haskellmode_completion_ghc = 0
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

" ReasonML related
Plug 'reasonml-editor/vim-reason-plus'

Plug 'autozimu/LanguageClient-neovim', {
	\ 'branch': 'next',
	\ 'do': 'bash install.sh',
	\ }
" Required for operations modifying multiple buffers like rename.
set hidden
let g:LanguageClient_serverCommands = {
	\ 'reason': ['ocaml-language-server', '--stdio'],
	\ 'ocaml': ['ocaml-language-server', '--stdio'],
	\ 'javascript': ['javascript-typescript-stdio'],
	\ }
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<cr>
nnoremap <silent> gf :call LanguageClient_textDocument_formatting()<cr>
nnoremap <silent> gs :call LanguageClient_textDocument_documentSymbol()<cr>
nnoremap <silent> <cr> :call LanguageClient_textDocument_hover()<cr>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Use deoplete.
let g:deoplete#enable_at_startup = 1
" use tab to forward cycle
inoremap <silent><expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
" use tab to backward cycle
inoremap <silent><expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"

Plug 'SirVer/ultisnips'
Plug 'hulufei/snippets'
let g:UltiSnipsExpandTrigger="ii"
let g:UltiSnipsJumpForwardTrigger="II"
let g:UltiSnipsJumpBackwardTrigger="OO"
" iI弹出UltiSnips的可用列表, 不常用的, 所以这里设置成了特殊的iI映射
let g:UltiSnipsListSnippets="iI"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetsDir='~/.local/share/nvim/plugged/snippets/UltiSnips'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
let g:fzf_action = {
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit'
      \ }
nnoremap <c-p> :FZF<cr>
nnoremap <leader>a :Ag
nnoremap <leader>A :exe 'Ag!' expand('<cword>')<cr>
nnoremap <leader>b :Buffers<cr>

" Elm related
" Plug 'elmcast/elm-vim'

Plug 'AndrewRadev/splitjoin.vim'
nmap sj :SplitjoinSplit<cr>
nmap sk :SplitjoinJoin<cr>

Plug 'bronson/vim-trailing-whitespace'
" Strip trailing whitespace
map <leader><space> :FixWhitespace<cr>

" Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'
let g:vim_jsx_pretty_colorful_config = 1

Plug 'mattn/emmet-vim'
let g:user_emmet_expandabbr_key = '<c-e>'

" Initialize plugin system
call plug#end()

" colorscheme NeoSolarized
colorscheme nova
set background=dark

set clipboard+=unnamedplus
set termguicolors
set relativenumber
set lazyredraw
set softtabstop=4
set tabstop=4
set shiftwidth=4
set lcs=tab:▸\ ,eol:¬,nbsp:_
" Don’t reset cursor to start of line when moving around.
set nostartofline
set foldmethod=syntax
" Change 99 to 0 to start with everything closed, if you prefer.
set foldlevel=99
set showbreak=↪

" Use the tab key match bracket pairs. It's a hell of a lot easier to type <tab> than <%>
nnoremap <tab> %
vnoremap <tab> %
" Makes j and k work the way you expect instead of working in some archaic
" 'movement by file line instead of screen line' fashion
nnoremap j gj
nnoremap k gk
" Quicker Escaping, note conflict when type 'jj' in insert mode
inoremap jj <ESC>

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
" Switch off the current search
nnoremap <silent> <Leader>/ :nohlsearch<CR>

" Save a file as root (,W)
noremap <leader>W :w !sudo tee % > /dev/null<CR>

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>

" Conflict with ctrlp
" :tnoremap <Esc> <C-\><C-n>
" Pomodoro thyme integration
" nmap <leader>t :!thyme -d<cr>

" Copy current buffer path relative to root of VIM session to system clipboard
nnoremap <Leader>yp :let @*=expand("%")<cr>:echo "Copied file path to clipboard"<cr>
" Copy current filename to system clipboard
nnoremap <Leader>yf :let @*=expand("%:t")<cr>:echo "Copied file name to clipboard"<cr>
" Copy current buffer path without filename to system clipboard
nnoremap <Leader>yd :let @*=expand("%:h")<cr>:echo "Copied file directory to clipboard"<cr>
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>
" Source the vimrc file after saving it
autocmd! bufwritepost init.vim source $MYVIMRC
nmap <leader>v :tabedit $MYVIMRC<CR>
" Use \d on top of a word to look it up in Dictionary.app
nmap <silent> <Leader>d :!open dict://<cword><CR><CR>

" Wrap Existing Text at 80 Characters in Vim
" Use `gq` to format
" au BufRead,BufNewFile *.md setlocal textwidth=80

" Make `crontab -e` work in macos
autocmd filetype crontab setlocal nobackup nowritebackup

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
