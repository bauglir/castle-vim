" Install vim-plug automatically if it's not available. Variation of
" https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
let s:vimplug_autoload_path=stdpath('data') . "/site/autoload/plug.vim"
if empty(glob(s:vimplug_autoload_path))
  echo 'Installing vim-plug…'

  silent execute '!curl ' .
    \ '--create-dirs ' .
    \ '--fail ' .
    \ '--location ' .
    \ '--output ' . s:vimplug_autoload_path . ' ' .
    \ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(stdpath('data') . '/plugged')
  " Extend `%` to include language specific words, instead of just single
  " characters. Drop-in replacement for matchit.vim including highlighting of
  " matches, etc.
  Plug 'andymass/vim-matchup'

  " Show Git hunks in the signs column and perform operations on them (e.g.
  " preview, stage, etc.)
  Plug 'airblade/vim-gitgutter'

  " Make it easier to work with column separated data
  Plug 'chrisbra/csv.vim'

  " Enable seamless movement between Vim splits and Tmux panes using Ctrl+HJKL
  "
  " The Tmux Navigator plugin requires additional configuration for seamless
  " integration with tmux. See https://github.com/christoomey/vim-tmux-navigator
  " for more details
  Plug 'christoomey/vim-tmux-navigator'

  " Enable asynchronous linting for syntax checking and semantic errors
  Plug 'dense-analysis/ale'

  " Enable faster motion-based movement without counts
  Plug 'easymotion/vim-easymotion'

  " Respect editorconfig files
  Plug 'editorconfig/editorconfig-vim'

  " Manage the Tmux status line from Vim, including matched theming
  Plug 'edkolev/tmuxline.vim'

  " Enable hex editing of binary files through `-b` command-line switch or by
  " invoking :Hexmode
  Plug 'fidian/hexmode'

  " Improve built-in Neovim LSP functionality with diagnostics jumping and
  " messages in popups
  Plug 'haorenW1025/diagnostic-nvim'

  " Enable extensive synchronized Markdown previews
  Plug 'iamcco/markdown-preview.nvim', {
    \ 'do': { -> mkdp#util#install() }
  \ }

  " Make the statusline look fancy and enable it to be easily extended with
  " new information
  "
  " This needs to come _after_ the definition of the color scheme, as the
  " statusline uses it
  Plug 'itchyny/lightline.vim'

  " Make the One Dark color scheme available
  Plug 'joshdick/onedark.vim'

  " Enable sending parts of a Vim buffer to a REPL (e.g. Julia, irb, etc.)
  " through tmux by pressing C-c C-c
  Plug 'jpalardy/vim-slime'

  " Enable Git (un)staging/committing right from within Vim
  Plug 'jreybert/vimagit'

  " Easily align different types of text blocks
  Plug 'junegunn/vim-easy-align'

  " Use fzf within Neovim for Ctrl+P like behavior amongst other things
  "
  " Updating the shell scripts is skipped during installation as the
  " configuration is already included in the castle-base dotfiles if fzf is
  " detected
  Plug 'junegunn/fzf', {
    \ 'dir': '~/.fzf',
    \ 'do': './install --key-bindings --completion --no-bash --no-fish --no-update-rc'
  \ }
  Plug 'junegunn/fzf.vim'

  " Show the contents of " and @ registers in a sidebar when the respective key
  " is pressed
  Plug 'junegunn/vim-peekaboo'

  " Enhance in-buffer searching with automatic clearing of highlights and
  " improved star-search
  Plug 'junegunn/vim-slash'

  " Highlight regions that got yanked
  Plug 'machakann/vim-highlightedyank'

  " Enable panel for navigating through symbols powered by language servers or
  " exuberant ctags
  Plug 'liuchengxu/vista.vim'

  " Enable navigation according to tags
  Plug 'majutsushi/tagbar'

  " Enable high speed HTML and CSS coding through shorthand
  Plug 'mattn/emmet-vim'

  " Improve the startup screen
  Plug 'mhinz/vim-startify'

  " Enable completions from a variety of sources (i.e. words in the active
  " buffer, paths, Tmux panes)
  Plug 'ncm2/ncm2' | Plug 'roxma/nvim-yarp'
  Plug 'ncm2/ncm2-bufword'
  Plug 'ncm2/ncm2-path'
  Plug 'ncm2/ncm2-tmux'

  " Enable ncm2 to detect fenced code blocks in Markdown files and provide
  " appropriate completions
  Plug 'ncm2/ncm2-markdown-subscope'

  " Provide default configurations for different language servers
  Plug 'neovim/nvim-lsp'

  " Enable management of buffers without closing windows or splits
  Plug 'qpkorr/vim-bufkill'

  " Automatically insert closing quotes, parentheses, etc.
  Plug 'Raimondi/delimitMate'

  " Enable searching https://devdocs.io right from Vim
  Plug 'rhysd/devdocs.vim'

  " Enable inspection of the Git history of a file from within Vim
  Plug 'rhysd/git-messenger.vim'

  " Make Vim understand a lot of different languages (e.g. for syntax
  " highlighting) with little to no overhead, instead of having to load the
  " desired ones one-by-one
  Plug 'sheerun/vim-polyglot'

  " Enable case-insensitive search/replace and coercion between different case
  " conventions (e.g. snake_case to camelCase, etc.)
  Plug 'tpope/vim-abolish'

  " Add extensive comment operator
  Plug 'tpope/vim-commentary'

  " Execute Git commands conveniently from within Neovim
  Plug 'tpope/vim-fugitive'

  " Make sessions easier to use
  Plug 'tpope/vim-obsession'

  " Enable repeating supported plugin maps with `.` (e.g. vim-surround)
  Plug 'tpope/vim-repeat'

  " Work with 'surroundings' (e.g. parentheses, brackets, etc) easily
  Plug 'tpope/vim-surround'

  " Pairs of useful bracket mappens (e.g. toggles, next/previous, etc.)
  Plug 'tpope/vim-unimpaired'

  " Enable tracking of code statistics using https://wakatime.com
  Plug 'wakatime/vim-wakatime'

  " Show indentation levels using vertical lines
  Plug 'Yggdroot/indentLine'

  " Show fancy icons in compatible places. This is required to come last as
  " per the README of the project
  Plug 'ryanoasis/vim-devicons'
call plug#end()

" Insert spaces instead of tabs, where a tab is two spaces
set expandtab shiftwidth=2 tabstop=2

" Allow buffers to be hidden when containing modifications (i.e. do not
" require a write before hiding)
set hidden

" Always show the current line number and relative numbers around that for
" easier navigation
set number
set relativenumber

" Searches are case-insensitive, unless they contain at least one capital
set ignorecase smartcase

" Always show the 'sign column' (this provides a more stable visual experience
" for feedback from GitGutter, etc.)
set signcolumn=yes

" Open splits in a more natural way (i.e. move the cursor to the newly created
" split instead of keeping it in the original split)
set splitbelow
set splitright

" Use fzf for fuzzy searching
set rtp+=~/.fzf
nmap <Leader>fbc <Cmd>BCommits<CR>
nmap <Leader>fbs <Cmd>BTags<CR>
nmap <Leader>fc <Cmd>Commits<CR>
nmap <Leader>ff <Cmd>Files<CR>
nmap <Leader>fh <Cmd>History<CR>
nmap <Leader>fl <Cmd>Lines<CR>
nmap ; <Cmd>Buffers<CR>
nmap <C-p> <Cmd>Files<CR>

" Use jj to exit insert mode
inoremap jj <Esc>

" Make sure the editorconfig plugin cooperates with Fugitive (from its README)
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" Target the second window in the second pane in tmux sessions with Slime by
" default
let g:slime_target = 'tmux'
let g:slime_default_config = {
\   'socket_name': 'default', 'target_pane': ':1.1'
\ }

" Force Vista to always use language servers, enable the preview pane of fzf
" and to render nice icons in the sidebar
"
" Make sure to install an appropriate font (e.g. from
" https://github.com/ryanoasis/nerd-fonts) for icons and such
let g:vista_default_executive = 'nvim_lsp'
let g:vista_fzf_preview = ['right:50%']
let g:vista_sidebar_width = 50
nmap <Leader>v <Cmd>Vista!!<CR>
nmap <Leader>fs <Cmd>Vista finder fzf:nvim_lsp<CR>

" Make `K` use https://devdocs.io for certain file types instead of searching
" local sources
augroup plugin-devdocs
  autocmd!
  autocmd FileType
  \       css,scss,html,javascript,julia,python,ruby,typescript
  \       nmap <buffer> K <Plug>(devdocs-under-cursor)
augroup END

" Enable EasyAlign plugin in visual mode (e.g. vipga) or from normal mode
" using motions/text objects (e.g. gaip)
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

" Always highlight the active column when editing column separated files
let g:csv_highlight_column = 'y'

" Automatically open a preview in the default browser when editing Markdown
" files
let g:mkdp_auto_start = 1
let g:mkdp_preview_options = {
\   'uml': {
\     'server': 'https://plantuml.gn-as.com'
\   }
\}

" Add shortcuts for Fugitive similar to those available through the Git plugin
" in Oh My ZSH
command -complete=file -nargs=* Ga G add <args>
command -nargs=* Gc G commit <args>
command -complete=file -nargs=* Gco G checkout <args>
command -complete=file -nargs=* Gd G diff <args>
command -complete=file -nargs=* Gds G diff --staged <args>
command -complete=file -nargs=* Gst G status <args>

exec 'source ' . stdpath('config') . '/statusline.vim'
exec 'source ' . stdpath('config') . '/theme.vim'

" The completion and diagnostics setup (i.e. empowering Vim with language
" servers, etc.) needs to occur after the theme has been set to prevent
" highlight groups from being overridden/cleared (e.g. LspDiagnostic*)
exec 'source ' . stdpath('config') . '/ide.vim'
