" vista
let g:vista_echo_cursor = 0  " Do not echo message on command line
let g:vista_stay_on_open = 0

nnoremap <silent> <leader>l :<C-U>Vista!!<CR>

" undotree
let g:undotree_WindowLayout = 2
let g:undotree_SplitWidth = 45

nnoremap <silent> <leader>u :UndotreeToggle<CR>

" neoformat
nnoremap <silent> <leader>f :Neoformat<CR>
let g:neoformat_enabled_json = ['jq']
let g:neoformat_enabled_lua = ['stylua']
let g:neoformat_enabled_sh = ['shfmt']
