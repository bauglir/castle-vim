" We don't need Vi compatibility
set nocompatible

" Support for showing ballons on the mouse hovering over symbols needs to be
" enabled before ALE is loaded
let g:ale_set_balloons = 1

" Automatically install vim-plug if it is not available
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
" Drop-in replacement for matchit.vim with syntax highlighting and more
Plug 'andymass/vim-matchup'
Plug 'airblade/vim-gitgutter'
Plug 'autozimu/LanguageClient-neovim', {
  \ 'branch': 'next',
  \ 'do': 'bash install.sh'
\ }
" The Tmux Navigator plugin requires additional configuration for seamless
" integration with tmux. See https://github.com/christoomey/vim-tmux-navigator
" for more details
Plug 'christoomey/vim-tmux-navigator'
" The Asynchronous Linting Engine for syntax checking and semantic errors
Plug 'dense-analysis/ale'
Plug 'editorconfig/editorconfig-vim'
Plug 'edkolev/tmuxline.vim'
" Enables sending parts of a Vim buffer to a REPL (e.g. Julia, irb, etc.)
" through tmux by pressing C-c C-c
Plug 'jpalardy/vim-slime'
Plug 'JuliaEditorSupport/julia-vim'
" Call the installation of fzf. Updating the shell scripts is skipped as the
" configuration is already included in the castle-base dotfiles if fzf is
" detected
Plug 'junegunn/fzf', {
  \ 'dir': '~/.fzf',
  \ 'do': './install --key-bindings --completion --no-bash --no-fish --no-update-rc'
\ }
Plug 'junegunn/fzf.vim'
" Shows the contents of " and @ registers in a sidebar when the respective key
" is pressed
Plug 'junegunn/vim-peekaboo'
" Enhances in-buffer searching with automatic clearing of highlights and
" improved star-search
Plug 'junegunn/vim-slash'
Plug 'leafgarland/typescript-vim'
Plug 'Lokaltog/vim-easymotion'
Plug 'majutsushi/tagbar'
Plug 'matze/vim-move'
" High speed HTML and CSS coding from shorthand
Plug 'mattn/emmet-vim'
Plug 'ncm2/ncm2'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-markdown-subscope'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-tmux'
Plug 'mileszs/ack.vim'
Plug 'Raimondi/delimitMate'
Plug 'reedes/vim-litecorrect'
Plug 'reedes/vim-pencil'
Plug 'rhysd/vim-grammarous'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'scrooloose/syntastic'
Plug 'sgeb/vim-matlab'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rails'
" Enables repeating supported plugin maps with .
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'thoughtbot/vim-rspec'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/bufkill.vim'
" Enables tracking of code statistics
Plug 'wakatime/vim-wakatime'
call plug#end()

" Manage whitespace
set nowrap                  " Do not wrap any lines
set tabstop=2 shiftwidth=2  " A tab is two spaces
set expandtab               " Use spaces, not tabs

" Allow buffers to be hidden when containing modifications (i.e. do not
" require a write before hiding)
set hidden

" Always show the current line number, but relative numbers around that for
" easy navigation
set number
set relativenumber

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

" Set up RSpec shorthands
map <Leader>t :w<CR> :call RunCurrentSpecFile()<CR>
map <Leader>s :w<CR> :call RunNearestSpec()<CR>
map <Leader>ls :w<CR> :call RunLastSpec()<CR>
map <Leader>a :w<CR> :call RunAllSpecs()<CR>
let g:rspec_command = "!rspec {spec}"

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

inoremap jj <ESC>

" Make sure the Alt modifier works in Gnome terminal (see
" https://stackoverflow.com/questions/6778961/alt-key-shortcuts-not-working-on-gnome-terminal-with-vim)
let c='a'
while c <= 'z'
  exec "set <A-".c.">=\e".c
  exec "imap \e".c." <A-".c.">"
  let c = nr2char(1+char2nr(c))
endw
set ttimeout ttimeoutlen=50

" Prose related configuration
augroup prose
  autocmd!

  " Enable spell checking for Markdown, YAML and text files and use vim-pencil
  " to force text to be wrapped using hard line breaks
  autocmd FileType markdown,yaml,text setlocal spell
                                      \ | call pencil#init({ 'wrap': 'hard' })
                                      \ | call litecorrect#init()
augroup end

" Enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()

" This will show the popup menu even if there's only one match (menuone),
" prevent automatic selection (noselect) and prevent automatic text injection
" into the current line (noinsert).
set completeopt=noinsert,menuone,noselect

" Use <TAB> to select the ncm2 popup menu
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

let g:default_julia_version = '0.6'

" Define Language Server Protocol Servers
let g:LanguageClient_serverCommands = {
  \ 'css': [ 'css-languageserver', '--stdio' ],
  \ 'html': [ 'html-languageserver', '--stdio' ],
  \ 'json': [ 'json-languageserver', '--stdio' ],
  \ 'julia': [ 'julia', '--startup-file=no', '--history-file=no', '-e', 'using LanguageServer; server = LanguageServer.LanguageServerInstance(STDIN, STDOUT, false); server.runlinter = true; run(server)' ],
  \ 'ruby': [ 'solargraph', 'stdio' ],
  \ 'scss': [ 'css-languageserver', '--stdio' ],
  \ 'typescript': [ 'typescript-language-server', '--stdio' ]
\ }

" Asynchronous Linting Engine (ALE) configuration
"
" Make sure the following external programs are installed to make the most of
" this plugin:
" - apt install jq
" - npm install -g prettier
" - pip install proselint
let g:ale_fixers = {
  \ '*': [ 'remove_trailing_lines', 'trim_whitespace' ],
  \ 'css': [ 'prettier' ],
  \ 'scss': [ 'prettier' ],
  \ 'html': [ 'prettier' ],
  \ 'javascript': [ 'prettier' ],
  \ 'json': [ 'jq' ],
  \ 'markdown': [ 'prettier' ],
  \ 'typescript': [ 'prettier' ]
\ }
let g:airline#extensions#ale#enabled = 1
let g:ale_completion_tsserver_autoimport = 1
let g:ale_fix_on_save = 1
noremap <Leader>fr :ALEFindReferences<CR>
noremap <Leader>jd :ALEGoToDefinition<CR>
noremap <Leader>oi :ALEOrganizeImports<CR>

" This assumes that typically the REPL vim is interacting with is in the
" second window in the second pane
let g:slime_target = 'tmux'
let g:slime_default_config = {
\ 'socket_name': 'default', 'target_pane': ':1.1'
\ }
