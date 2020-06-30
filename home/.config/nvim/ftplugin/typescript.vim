let b:ale_fixers = [ 'prettier' ]

" Enable running Compodoc quickly for Angular projects.
"
" The `finddir` construct resolves to the folder above a `.git` folder found
" when searching upwards through the file tree relative to the file in the
" current buffer
nmap <buffer> <Leader>cd
\    <Cmd>silent execute '!' .
\         finddir('.git/..', expand('%:p:h') . ';') .
\         '/node_modules/.bin/compodoc'<CR>
