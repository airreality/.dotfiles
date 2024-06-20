" vista
let g:vista_echo_cursor = 0  " Do not echo message on command line
let g:vista_stay_on_open = 0

nnoremap <silent> <leader>l :<C-U>Vista!!<CR>

" undotree
let g:undotree_WindowLayout = 2
let g:undotree_SplitWidth = 45

nnoremap <silent> <leader>u :UndotreeToggle<CR>

" delimitMate
let b:delimitMate_matchpairs = "(:),[:],{:}"

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

" wilder.nvim
call timer_start(250, { -> s:wilder_init() })

function! s:wilder_init() abort
  try
    call wilder#setup({
          \ 'modes': [':', '/', '?'],
          \ 'next_key': '<Tab>',
          \ 'previous_key': '<S-Tab>',
          \ 'accept_key': '<C-y>',
          \ 'reject_key': '<C-e>'
          \ })

    call wilder#set_option('pipeline', [
          \ wilder#branch(
          \   wilder#cmdline_pipeline({
          \     'language': 'python',
          \     'fuzzy': 1,
          \     'sorter': wilder#python_difflib_sorter(),
          \     'debounce': 30,
          \   }),
          \   wilder#python_search_pipeline({
          \     'pattern': wilder#python_fuzzy_pattern(),
          \     'sorter': wilder#python_difflib_sorter(),
          \       'engine': 're',
          \       'debounce': 30,
          \     }),
          \   ),
          \ ])

    let l:hl = wilder#make_hl('WilderAccent', 'Pmenu', [{}, {}, {'foreground': '#f4468f'}])
    call wilder#set_option('renderer', wilder#popupmenu_renderer({
          \ 'highlighter': wilder#basic_highlighter(),
          \ 'max_height': 15,
          \ 'highlights': {
          \   'accent': l:hl,
          \ },
          \ 'left': [' ', wilder#popupmenu_devicons(),],
          \ 'right': [' ', wilder#popupmenu_scrollbar(),],
          \ 'apply_incsearch_fix': 0,
          \ }))
  catch /^Vim\%((\a\+)\)\=:E117/
    echohl Error |echomsg "Wilder.nvim missing"| echohl None
  endtry
endfunction
