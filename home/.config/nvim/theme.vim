" Enable the 'dark' OneDark color scheme, using true colors if they are
" available and enabling italics for comments, etc.
if has('termguicolors')
  set termguicolors
endif
let g:onedark_terminal_italics = 1
set background=dark
colorscheme onedark

" Mark indentation levels using a Unicode glyph that's easier on the eyes than
" the default pipe character
let g:indentLine_char = '▏'
