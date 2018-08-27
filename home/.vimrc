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
Plugin 'autozimu/LanguageClient-neovim'
" The Tmux Navigator plugin requires additional configuration for seamless
" integration with tmux. See https://github.com/christoomey/vim-tmux-navigator
" for more details
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'edkolev/tmuxline.vim'
Plugin 'JuliaLang/julia-vim'
Plugin 'junegunn/fzf.vim'
Plugin 'leafgarland/typescript-vim'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'majutsushi/tagbar'
Plugin 'matze/vim-move'
Plugin 'ncm2/ncm2'
Plugin 'ncm2/ncm2-bufword'
Plugin 'ncm2/ncm2-path'
Plugin 'ncm2/ncm2-tmux'
Plugin 'mileszs/ack.vim'
Plugin 'Raimondi/delimitMate'
Plugin 'roxma/nvim-yarp'
Plugin 'roxma/vim-hug-neovim-rpc'
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

" Always show the 'sign column' (this provides a more stable experience for
" feedback from GitGutter and LanguageClient)
set signcolumn=yes

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

" Use fzf for fuzzy (file) searching
set rtp+=~/.fzf
nmap ; :Buffers<CR>
nmap <C-p> :Files<CR>
nmap <C-t> :Tags<CR>

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

inoremap jk <ESC>

" Make sure the Alt modifier works in Gnome terminal (see
" https://stackoverflow.com/questions/6778961/alt-key-shortcuts-not-working-on-gnome-terminal-with-vim)
let c='a'
while c <= 'z'
  exec "set <A-".c.">=\e".c
  exec "imap \e".c." <A-".c.">"
  let c = nr2char(1+char2nr(c))
endw
set ttimeout ttimeoutlen=50

" Enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()

" This will show the popup menu even if there's only one match (menuone),
" prevent automatic selection (noselect) and prevent automatic text injection
" into the current line (noinsert).
set completeopt=noinsert,menuone,noselect

" Use <TAB> to select the ncm2 popup menu
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Define Language Server Protocol Servers
let g:LanguageClient_serverCommands = {
  \ 'css': [ 'css-languageserver', '--stdio' ],
  \ 'html': [ 'html-languageserver', '--stdio' ],
  \ 'json': [ 'json-languageserver', '--stdio' ],
  \ 'ruby': [ 'solargraph', 'stdio' ],
  \ 'scss': [ 'css-languageserver', '--stdio' ],
  \ 'typescript': [ 'typescript-language-server', '--stdio' ]
\ }
