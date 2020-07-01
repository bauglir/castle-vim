" Asynchronous Linting Engine (ALE) configuration
"
" Linting is turned off for those file types where language servers are used
" to provide the same functionality
let g:ale_fix_on_save = 1
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\ }
let g:ale_linters = {
\   'css': [],
\   'html': [],
\   'javascript': [],
\   'julia': [],
\   'scss': [],
\   'typescript': []
\ }

" Enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()

" Adjust settings for Insert mode completion compatible with ncm2. See :help
" Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect

" Suppress the annoying 'match x of y', 'The only match' and 'Pattern not
" found' messages
set shortmess+=c

" Write swapfiles to disk more often, this is mainly for affecting the
" CursorHold event to fire faster so it can be used for showing diagnostics.
" This also affects how fast markdown-preview.nvim rerenders previews.
set updatetime=100

" CTRL-C doesn't trigger the InsertLeave autocmd. map to <ESC> instead
inoremap <C-c> <Esc>

" When the <Enter> key is pressed while the popup menu is visible, it only
" hides the menu. This mapping closes the menu and starts a new line
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<CR>" : "\<CR>")

" Use <Tab> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Define normal bindings to cycle through diagnostics provided by
" diagnostic-nvim
nmap [g :NextDiagnosticCycle<CR>
nmap ]g :PrevDiagnosticCycle<CR>

" Use Nerd Fonts to get nice icons for diagnostic messages in the sign column
call sign_define('LspDiagnosticsErrorSign', {'text' : '✘', 'texthl' : 'LspDiagnosticsError'})
call sign_define('LspDiagnosticsWarningSign', {'text' : '', 'texthl' : 'LspDiagnosticsWarning'})
call sign_define('LspDiagnosticsInformationSign', {'text' : '', 'texthl' : 'LspDiagnosticsInformation'})
call sign_define('LspDiagnosticsHintSign', {'text' : '', 'texthl' : 'LspDiagnosticsHint'})

" Register language servers managed through nvim-lsp with ncm2 and hook up to
" native LSP functionality
lua << EOF
local diagnostic = require('diagnostic')
local nvim_command = vim.api.nvim_command
local nvim_lsp = require('nvim_lsp')
local ncm2 = require('ncm2')

local language_servers = {
  'cssls', 'dockerls', 'html', 'jsonls', 'julials', 'tsserver', 'vimls', 'yamlls'
}

local lsp_commands = {
  ['<C-]>'] = 'definition',
  ['<F2>'] = 'rename',
  g0 = 'document_symbol',
  gD = 'implementation',
  gDT = 'type_definition',
  gH = 'hover',
  gd = 'declaration',
  gr = 'references',
  gW = 'workspace_symbol'
}

local on_attach = function(client, bufnr)
  diagnostic.on_attach()

  -- Show diagnostics after `updatetime` when 'hovering' on a text object with
  -- the cursor
  nvim_command('autocmd CursorHold <buffer> lua vim.lsp.util.show_line_diagnostics()')

  -- Bind keys to useful language server commands
  for key, command in pairs(lsp_commands) do
    nvim_command(string.format(
      'nnoremap <silent> <buffer> %s <Cmd>lua vim.lsp.buf.%s()<CR>',
      key, command
    ))
  end
end

for _, language_server in ipairs(language_servers) do
  nvim_lsp[language_server].setup{
    on_attach = on_attach,
    on_init = ncm2.register_lsp_source
  }
end
EOF
