" Change the <leader> key, <,> is easier to type than <\>
let mapleader = ","

call plug#begin('~/.local/share/nvim/plugged')

" Plug 'iCyMind/NeoSolarized'
" First install tex distribution: http://www.tug.org/mactex/morepackages.html
" Install latexmk if not exist: tlmgr install latexmk
Plug 'lervag/vimtex'
let g:tex_flavor = 'latex'
" let g:vimtex_compiler_method = 'tectonic'

" Broke svelte nerdcommenter, use individual syntax highlight plugin instead
" Plug 'sheerun/vim-polyglot'
" let g:polyglot_disabled = ['latex']

Plug 'evanleck/vim-svelte', {'branch': 'main'}
Plug 'pangloss/vim-javascript'
Plug 'HerringtonDarkholme/yats.vim'

" Sql related
Plug 'lifepillar/pgsql.vim'
let g:sql_type_default = 'pgsql'
Plug 'tpope/vim-dadbod'

" https://github.com/chriskempson/base16-vim
Plug 'chriskempson/base16-vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'airblade/vim-gitgutter'

Plug 'jiangmiao/auto-pairs'

Plug 'bronson/vim-visual-star-search'
Plug 'henrik/vim-indexed-search'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-obsession'
Plug 'godlygeek/tabular'
Plug 'nathangrigg/vim-beancount'

" Plug 'blindFS/vim-taskwarrior'
" nnoremap <leader>t :tabnew <bar> :TW<CR>

Plug 'vimwiki/vimwiki', {'branch': 'dev'}
" Make <Tab> work as normal
let g:vimwiki_table_mappings = 0
let g:vimwiki_folding = 'expr'
let nested_syntaxes = {'python': 'python', 'c++': 'cpp', 'reason': 'reason', 'javascript': 'javascript', 'rust': 'rust'}
" :nmap <Leader>wn <Plug>VimwikiNextLink
" :nmap <Leader>wp <Plug>VimwikiPrevLink
let wiki = {}
let wiki.path = '~/Dropbox/vimwiki'
let wiki.syntax = 'markdown'
let wiki.ext = '.md'
let wiki.auto_toc = 1
let wiki.auto_tags = 1

" <leader>ws select wikis ui
let zola = {}
let zola.path = '~/Dropbox/pkb/content'
let zola.syntax = 'markdown'
let zola.ext = '.md'
let zola.auto_toc = 1
" Compatible with zola
let zola.index = '_index'

let g:vimwiki_list = [wiki, zola]
map <Leader>tt <Plug>VimwikiToggleListItem
" <bar> chain commands
" :tcd set the current directory for the current tab and window.
" %:h the directory of the current file
" :nmap <Leader>wt <Plug>VimwikiTabIndex <bar> :tcd %:p:h:h <bar> :Async zola serve<cr>
nmap <Leader>wt <Plug>VimwikiTabIndex <bar> :tcd %:h<cr>
nmap <Leader>ww <Plug>VimwikiIndex <bar> :tcd %:h<cr>
nmap <Leader>cd :tcd %:h<cr>

Plug 'michal-h21/vim-zettel'
let g:zettel_format = "%y%m%d-%title"
nnoremap <leader>zn :ZettelNew<space>

" Setup completion popup menu work just like in an IDE
" Don't auto select first item
set completeopt=longest,menuone
" Completion for relative path
autocmd InsertEnter * let save_cwd = getcwd() | set autochdir
" Reset current directory
autocmd InsertLeave * set noautochdir | execute 'cd' fnameescape(save_cwd)
" Case is ignored when completing file names and directories.
set wildignorecase

" ]n and [n jump to conflict section is awesome
" ]q and [q jump to errors in quickfix
Plug 'tpope/vim-unimpaired'

Plug 'skywind3000/asyncrun.vim'
" Support customize in running
let qf_height_lines = 25
augroup asyncrun
  autocmd User AsyncRunStart call asyncrun#quickfix_toggle(qf_height_lines, 1)
augroup END
noremap <leader>q :call asyncrun#quickfix_toggle(qf_height_lines)<cr>
nnoremap <leader>e :AsyncRun
" Cooperate with vim-fugitive
command! -bang -nargs=* -complete=file Make AsyncRun -program=make @ <args>
" Cooperate asyncrun with vim-airline
let g:asyncrun_status = ''
autocmd VimEnter * let g:airline_section_error = airline#section#create_right(['%{g:asyncrun_status}'])

Plug 'JoshMcguigan/estream', { 'do': 'bash install.sh v0.1.1' }

" Disable python std out buffering when running async
let $PYTHONUNBUFFERED=1
" Set global error format to match estream output
set errorformat=%f\|%l\|%c,%f\|%l\|,%f\|\|
" Use global error format with asyncrun
let g:asyncrun_local = 0

" Pipe any async command through estream to format it as expected
" by the errorformat setting above
" example: `:Async cargo test`
" Unfortunately can't set multiple attribute to -complete:
" https://stackoverflow.com/questions/21499048/setting-multiple-values-for-vim-command-complete-attribute
command! -nargs=1 -complete=file Async execute "AsyncRun <args> |& ~/.local/share/nvim/plugged/estream/bin/estream"
nnoremap <leader>ac :Async
nnoremap <leader>s :AsyncStop<CR>

" Create a file watcher, primarily used with Async using the mapping below
command! -nargs=1 Watch augroup watch | exe "autocmd! BufWritePost * <args>" | augroup END
command! NoWatch autocmd! watch

" Use to run a command on every file save, pipe it through estream
" and view it in the quickfix window.
" example: `:Watch Async cargo test`
nnoremap <leader>w :Watch Async
nnoremap <leader>nw :NoWatch<CR>

" ========== coc config start ===========
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" ## Tips
" - To navigate forward/backward of a snippet placeholder, use <C-j> and <C-k>.
let g:coc_global_extensions = [
      \'coc-json',
      \'coc-tsserver',
      \'coc-svelte',
      \'coc-rust-analyzer',
      \'coc-eslint',
      \'coc-prettier',
      \'coc-ultisnips',
      \]
" Setup format: npm add -D prettier prettier-plugin-svelte
" It will help us set the filetype based on the file section.
Plug 'Shougo/context_filetype.vim'

" mostly I use <C-w>p for jump to last opened (error)window
set mouse=a

" if hidden is not set, TextEdit might fail.
set hidden
" Some servers have issues with backup files, see #649
" set nobackup
" set nowritebackup

" Better display for messages
set cmdheight=2

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Use `[c` and `]c` to navigate diagnostics
nmap <silent> <leader>k <Plug>(coc-diagnostic-prev-error)
nmap <silent> <leader>j <Plug>(coc-diagnostic-next-error)
nmap <silent> <leader>wk <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>wj <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gD <Plug>(coc-declaration)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gn <Plug>(coc-rename)
" Fix autofix problem of current line
nmap <silent> gx <Plug>(coc-fix-current)
" Remap keys for applying codeAction to the current buffer.(eg. fixAll)
nmap <silent> ga <Plug>(coc-codeaction)
" get full diagnostic info
nmap <silent> gI <Plug>(coc-diagnostic-info)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
" ========== coc config end ===========

Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
" let g:airline_solarized_bg='dark'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

" Yank and paste a window with <leader>ww
Plug 'wesQ3/vim-windowswap'
" Conflict with vimwiki, disable it
let g:windowswap_map_keys=0

Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
map <c-o> :NERDTreeFind<cr>

Plug 'preservim/nerdcommenter'
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

" ReasonML related
" Plug 'reasonml-editor/vim-reason-plus'
Plug 'rescript-lang/vim-rescript'

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
autocmd filetype javascriptreact :UltiSnipsAddFiletypes javascriptreact.javascript

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
" let g:elm_format_autosave = 0

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
let g:user_emmet_settings = {
\ 'typescript' : {
\     'extends' : 'jsx',
\ },
\ 'javascript' : {
\     'extends' : 'jsx',
\ },
\}

" Initialize plugin system
call plug#end()

colorscheme base16-solarized-light

" should appear after the |:colorscheme| command
hi! CocErrorSign guifg=#df8c8c
hi! link SignColumn LineNr

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
" no highlight
nmap <leader>x :let @/=""<CR>

" <Esc> will conflict with ctrlp
:tnoremap jj <C-\><C-n>
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

autocmd BufNewFile,BufRead *.har set filetype=json
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

" https://github.com/fanzeyi/cargo-play
command! CargoPlay !cargo play %

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

" -------------------------------------
" Context filetypes for NERDCommenter and more
" -------------------------------------
if !exists('g:context_filetype#same_filetypes')
  let g:context_filetype#filetypes = {}
endif
let g:context_filetype#filetypes.svelte =
\ [
\   {'filetype' : 'javascript', 'start' : '<script>', 'end' : '</script>'},
\   {
\     'filetype': 'typescript',
\     'start': '<script\%( [^>]*\)\? \%(ts\|lang="\%(ts\|typescript\)"\)\%( [^>]*\)\?>',
\     'end': '</script>',
\   },
\   {'filetype' : 'css', 'start' : '<style \?.*>', 'end' : '</style>'},
\ ]


let g:NERDCustomDelimiters = { 'html': { 'left': '<!--', 'right': '-->' } }
" -------------------------------------
" NERDCommenter
" -------------------------------------
let g:ft = ''
fu! NERDCommenter_before()
  if (&ft == 'html') || (&ft == 'svelte') || (&ft == 'vue')
    let g:ft = &ft
    let cfts = context_filetype#get_filetypes()
    if len(cfts) > 0
      if cfts[0] == 'svelte'
        let cft = 'html'
      elseif cfts[0] == 'scss'
        let cft = 'css'
      else
        let cft = cfts[0]
      endif
      " echo 'before comment setf ' . cft
      exe 'setf ' . cft
    endif
  endif
endfu
fu! NERDCommenter_after()
  if (g:ft == 'html') || (g:ft == 'svelte') || (g:ft == 'vue')
    exe 'setf ' . g:ft
    " echo 'after comment setf ' . g:ft
    let g:ft = ''
  endif
endfu
