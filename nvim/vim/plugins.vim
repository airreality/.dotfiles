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

" vim-test
let test#strategy="neovim"
let test#python#runner="pytest"
nmap <Leader>n :TestNearest<CR>
nmap <Leader>m :TestFile<CR>

" vim-markdown
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_conceal = 0
let g:tex_conceal = ''
let g:vim_markdown_math = 0
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_json_frontmatter = 1
let g:vim_markdown_toc_autofit = 1

" markdown-preview

""" do not close preview window on buffer changing
let g:mkdp_auto_close = 0

" vim-sandwich
" map s to nop since s is used by vim-sandwich, use cl instead of s
nmap s <Nop>
omap s <Nop>
