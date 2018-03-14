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
Plugin 'edkolev/tmuxline.vim'
Plugin 'JuliaLang/julia-vim'
Plugin 'kien/ctrlp.vim'
Plugin 'leafgarland/typescript-vim'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'majutsushi/tagbar'
Plugin 'mileszs/ack.vim'
Plugin 'Raimondi/delimitMate'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'sgeb/vim-matlab'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'thoughtbot/vim-rspec'
Plugin 'valloric/YouCompleteMe'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
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
set wildignore+=*bower_components*,dist,*node_modules*,tmp

" Enable mouse interactions
set ttyfast
set mouse=a
set ttymouse=xterm2

" Set Ack.vim to use the_silver_searcher
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
end

let EditorConfig_exclude_patterns = ['fugitive://.*']

colorscheme railscasts

let g:airline_theme = 'wombat'
let g:tmuxline_preset = {
  \'a'    : '#S',
  \'b'    : '#(uptime | cut -d "," -f1 | cut -d " " -f4-)',
  \'c'    : '#(whoami)',
  \'win'  : '#I #W',
  \'cwin' : [ '#I', '#W', '#F' ],
  \'x'    : '%R',
  \'y'    : '%F',
  \'z'    : [ '#h', "#(ifconfig enp3s0 | grep inet | awk '{print $2}' | sed 's/addr://g' | head -n 1)" ]}
