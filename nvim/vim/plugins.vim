" undotree
let g:undotree_WindowLayout = 2
let g:undotree_SplitWidth = 45

nnoremap <silent> <leader>u :UndotreeToggle<CR>

" neoformat
nnoremap <silent> <leader>f :Neoformat<CR>
let g:neoformat_enabled_json = ['jq']
let g:neoformat_enabled_lua = ['stylua']
let g:neoformat_enabled_sh = ['shfmt']
