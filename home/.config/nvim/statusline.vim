" This needs to be set before altering the colorscheme, or the colors will not
" be applied correctly
let g:lightline = {
\   'colorscheme': 'onedark',
\   'component_function': {
\     'filetype': 'IconFileType',
\     'fileformat': 'IconFileFormat'
\   }
\ }

function! IconFileType()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! IconFileFormat()
  return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction

let g:tmuxline_preset = {
\  'a'    : '#S',
\  'b'    : '#(uptime | cut -d "," -f1 | cut -d " " -f4-)',
\  'c'    : '#(whoami)',
\  'win'  : '#I #W',
\  'cwin' : [ '#I', '#W', '#F' ],
\  'x'    : '%R',
\  'y'    : '%F',
\  'z'    : [ '#h', "#(ifconfig enp3s0 | grep inet | awk '{print $2}' | sed 's/addr://g' | head -n 1)" ]
\ }

" Don't show the active mode in the command line area as it's shown in the
" status line already
set noshowmode

" Synchronize the tmux status line with the Vim one if inside a tmux session
if exists('$TMUX')
  autocmd VimEnter * Tmuxline lightline
endif
