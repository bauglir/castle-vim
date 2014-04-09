" We don't need Vi compatibility
set nocompatible 

" Required for Vundle
filetype off 

" Make sure the runtimepath includes Vundle
set runtimepath+=~/.vim/bundle/vundle
call vundle#rc()

" Set bundles to be managed by Vundle (this should include Vundle itself!)
Bundle 'gmarik/vundle'

Bundle 'airblade/vim-gitgutter'
" The Tmux Navigator plugin requires additional configuration for seamless
" integration with tmux. See https://github.com/christoomey/vim-tmux-navigator
" for more details
Bundle 'christoomey/vim-tmux-navigator'
Bundle 'ervandew/supertab'
Bundle 'JuliaLang/julia-vim'
Bundle 'kchmck/vim-coffee-script'
Bundle 'kien/ctrlp.vim'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'majutsushi/tagbar'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'Raimondi/delimitMate'
Bundle 'sgeb/vim-matlab'
Bundle 'SirVer/ultisnips'
" The Instant Markdown plugin has additional dependencies, see
" https://github.com/suan/vim-instant-markdown for installation instructions
Bundle 'suan/vim-instant-markdown'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-sensible'
Bundle 'tpope/vim-surround'
Bundle 'thoughtbot/vim-rspec'
Bundle 'vim-scripts/bufkill.vim'

" Manage whitespace
set nowrap                  " Do not wrap any lines
set tabstop=2 shiftwidth=2  " A tab is two spaces
set expandtab               " Use spaces, not tabs

" Allow buffers to be hidden when containing modifications (i.e. do not
" require a write before hiding)
set hidden

" Always show line numbers
set number

" Open splits in a more natural way (i.e. move the cursor to the newly
" created split)
set splitbelow
set splitright

" Set up some search options
set hlsearch    " Highlight matches
set ignorecase 	" Searches are case-insensitive
set smartcase 	" ... unless they contain at least one capital letter

" Set up RSpec shorthands to be run through Zeus
map <Leader>t :w<CR> :call RunCurrentSpecFile()<CR>
map <Leader>s :w<CR> :call RunNearestSpec()<CR>
map <Leader>ls :w<CR> :call RunLastSpec()<CR>
map <Leader>a :w<CR> :call RunAllSpecs()<CR>
let g:rspec_command = "!zeus rspec {spec}"

" Set up keymaps for GitGutter hunk movements
map <Leader>ggn :GitGutterNextHunk<CR>
map <Leader>ggp :GitGutterPrevHunk<CR>
