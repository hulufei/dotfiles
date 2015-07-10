" set background=light
colorscheme solarized
set ch=2 " Make command line two lines high

"set mousehide " Hide the mouse when typing text

" Make shift-insert work like in Xterm
"map <S-Insert> <MiddleMouse>
"map! <S-Insert> <MiddleMouse>

" Show the tabline
set showtabline=1

" Show tab pages
set guioptions+=e

" Function that puts a number into the tab label
set guitablabel=(%N)\ %t

"set guifont=Monaco:h12

set go-=T
set go-=l
set go-=L

" Use the excellent Railscat theme by Jeff Kreeftmeijer (gVim-only)
"colorscheme railscat
" Use 14pt Menlo
set guifont=Menlo:h12
" Better line-height
set linespace=5
