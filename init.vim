" ==================== Editor behavior ====================
filetype on
set clipboard=unnamedplus
let &t_ut=''
set autochdir
set exrc
set secure
set number
set relativenumber
set cursorline
set noexpandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set list
set listchars=tab:\|\ ,trail:▫
set scrolloff=4
set ttimeoutlen=0
set notimeout
set viewoptions=cursor,folds,slash,unix
set wrap
set tw=0
set indentexpr=
set foldmethod=indent
set foldlevel=99
set foldenable
set formatoptions-=tc
set splitright
set splitbelow
set noshowmode
set ignorecase
set smartcase
set shortmess+=c
set inccommand=split
set completeopt=longest,noinsert,menuone,noselect,preview
set lazyredraw
set visualbell
" ==================== Basic Mappings ====================
let mapleader=" "
" Open the vimrc file anytime
nnoremap <LEADER>rc :e $HOME/.config/nvim/init.vim<CR>

" Search 正常模式下按 空格+回车 取消高亮显示 
noremap <LEADER><CR> :nohlsearch<CR>


" 插入模式下上下左右的映射
inoremap <A-h> <left>
inoremap <A-l> <right>
inoremap <A-j> <down>
inoremap <A-k> <up>



" ==================== Plug install ====================
call plug#begin('~/.config/nvim/plugged')
"  中文文档
Plug 'yianwillis/vimcdoc'


"  主题
Plug 'sainnhe/sonokai'

"  主题.vim
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"  coc.nvim
Plug 'neoclide/coc.nvim', {'branch': 'release'}


" Undo Tree
Plug 'mbbill/undotree'

" markdown 
"  如果出现报错,nvim包里面执行yarn install 然后回来重装即可
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
" 自动序列
Plug 'dkarter/bullets.vim'
Plug 'mzlogin/vim-markdown-toc'

" git相关
Plug 'airblade/vim-gitgutter'

call plug#end()

" ==================== 皮肤和状态栏 ====================
" Important!!
if has('termguicolors')
    set termguicolors
endif
" The configuration options should be placed before `colorscheme sonokai`.
let g:sonokai_style = 'maia'
let g:sonokai_better_performance = 1
colorscheme sonokai

" airline themes
let g:airline_theme='base16'
let g:airline#extensions#tabline#enabled = 1

" ==================== coc.nvim====================
let g:coc_global_extensions = [
        \ 'coc-json',
        \ 'coc-vimlsp',
        \ 'coc-pyright',
        \ 'coc-explorer']


" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction


" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"


" Use K to show documentation in preview window.
" 显示文档
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction


" Use <c-space> to trigger completion.
if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
  else
    inoremap <silent><expr> <c-@> coc#refresh()
  endif



" ==================== Undotree ====================
noremap L :UndotreeToggle<CR>
let g:undotree_WindowLayout = 2
let g:undotree_ShortIndicators = 1
let g:undotree_SplitWidth = 24
let g:undotree_DiffAutoOpen = 1
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_DiffpanelHeight = 8

" =================== undotree ==========
"  Usually, I would like to store the undo files in a separate place like below.
if has("persistent_undo")
  let target_path = expand('~/.undodir')

   " create the directory and any parent directories
   " if the location does not exist.
   if !isdirectory(target_path)
       call mkdir(target_path, "p", 0700)
   endif

   let &undodir=target_path
   set undofile
endif




" =================== plug map ==================
nnoremap <c-c> :CocCommand<CR>
nnoremap tt :CocCommand explorer<CR>


" =================== Compile function ==========

" Compile function
  noremap RR :call CompileRunGcc()<CR>
  func! CompileRunGcc()
    exec "w"
    if &filetype == 'python'
      set splitbelow
      :sp
      :term python3 %
    elseif &filetype == 'markdown'
      exec "MarkdownPreviewToggle"
    endif
  endfunc
" =================== markdown ==========
" specify browser to open preview page
" for path with space
" valid: `/path/with\ space/xxx`
" invalid: `/path/with\\ space/xxx`
" default: ''
let g:mkdp_browser = 'firefox'

" ==================== Bullets.vim ====================
" Bullets.vim
let g:bullets_enabled_file_types = [
    \ 'markdown',
    \ 'text',
    \ 'gitcommit',
    \ 'scratch'
    \]


" ==================== Markdown Settings ====================
" Snippets
source $HOME/.config/nvim/md-snippets.vim
" auto spell
autocmd BufRead,BufNewFile *.md setlocal spell
 "启用Markdown拼写检查
 

" ==================== vim-markdown-toc ====================
let g:vmt_cycle_list_item_markers = 1
let g:vmt_fence_text = 'TOC'
let g:vmt_fence_closing_text = '/TOC'




" ==================== GitGutter ====================
let g:gitgutter_sign_allow_clobber = 0
let g:gitgutter_map_keys = 0
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_preview_win_floating = 1
let g:gitgutter_sign_added = '▎'
let g:gitgutter_sign_modified = '░'
let g:gitgutter_sign_removed = '▏'
let g:gitgutter_sign_removed_first_line = '▔'
let g:gitgutter_sign_modified_removed = '▒'
nnoremap <LEADER>gf :GitGutterFold<CR>
nnoremap H :GitGutterPreviewHunk<CR>
nnoremap <LEADER>g- :GitGutterPrevHunk<CR>
nnoremap <LEADER>g= :GitGutterNextHunk<CR>
