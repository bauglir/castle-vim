" We don't need Vi compatibility
set nocompatible

" Required for Vundle
filetype off

" Make sure the runtimepath includes Vundle
set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Set bundles to be managed by Vundle (this should include Vundle itself!)
Plugin 'VundleVim/Vundle.vim'

Plugin 'airblade/vim-gitgutter'
" The Tmux Navigator plugin requires additional configuration for seamless
" integration with tmux. See https://github.com/christoomey/vim-tmux-navigator
" for more details
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'ervandew/supertab'
Plugin 'JuliaLang/julia-vim'
Plugin 'kchmck/vim-coffee-script'
Plugin 'kien/ctrlp.vim'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'majutsushi/tagbar'
Plugin 'Raimondi/delimitMate'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'sgeb/vim-matlab'
Plugin 'SirVer/ultisnips'
" The Instant Markdown plugin has additional dependencies, see
" https://github.com/suan/vim-instant-markdown for installation instructions
Plugin 'suan/vim-instant-markdown'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-surround'
Plugin 'thoughtbot/vim-rspec'
Plugin 'vim-scripts/bufkill.vim'

" All of the plugins must be added before this line
call vundle#end()
filetype plugin indent on

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
set ignorecase  " Searches are case-insensitive
set smartcase   " ... unless they contain at least one capital letter

" Set up RSpec shorthands to be run through Zeus
map <Leader>t :w<CR> :call RunCurrentSpecFile()<CR>
map <Leader>s :w<CR> :call RunNearestSpec()<CR>
map <Leader>ls :w<CR> :call RunLastSpec()<CR>
map <Leader>a :w<CR> :call RunAllSpecs()<CR>
let g:rspec_command = "!zeus rspec {spec}"

" Set up keymaps for GitGutter hunk movements
map <Leader>ggn :GitGutterNextHunk<CR>
map <Leader>ggp :GitGutterPrevHunk<CR>

" Ignore directories commonly found in (JavaScript) projects containing dependencies
set wildignore+=*bower_components*,dist,*node_modules*

" Enable mouse interactions
set ttyfast
set mouse=a
set ttymouse=xterm2

let EditorConfig_exclude_patterns = ['fugitive://.*']

colorscheme railscasts
