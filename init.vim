" ==================== Editor behavior ====================
"  让某些终端可能显示颜色有问题修复正常
let &t_ut=''
" 显示当前行光标
set cursorline
"使用系统寄存器(剪切板)
set clipboard=unnamedplus
" 显示行号
set number
" 设置相对行号
set relativenumber
" 设置自动这行
set wrap
" 是否显示状态栏
set laststatus=2
" 语法高亮
syntax on
" 支持鼠标
set mouse=a
" 设置编码格式
set encoding=utf-8
" 启用256色
"  set t_Co=256
" 开启文件类型检查
filetype indent on
" 设置自动缩进
set autoindent
" 设置tab缩进数量
set tabstop=4
" 设置>>与<<的缩进数量
set shiftwidth=4
" 将缩进转换为空格
set expandtab
" 自动高亮匹配符号
set showmatch
" 自动高亮匹配搜索结果
set hlsearch
" 边搜索边高亮
set incsearch
" 开启类型检查
set spell spelllang=en_us
" 开启命令补全
set wildmenu
" 不创建备份文件
set nobackup
" 不创建交换文件
set noswapfile
" 多窗口下光标移动到其他窗口时自动切换工作目录
set autochdir
" 忽略大小写
set ignorecase
" 智能大小写
set smartcase
" 取消自带模式显示
set noshowmode
"  自动补全不自动选中
set completeopt=longest,noinsert,menuone,noselect,preview
" 等待命令的刷新率
set updatetime=100
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" ==================== Basic Mappings ====================
let mapleader=" "

" Search 正常模式下按 空格+回车 取消高亮显示 
noremap <LEADER><CR> :nohlsearch<CR>
" ==================== Plug install ====================
call plug#begin('~/.config/nvim/plugged')
"  中文文档
Plug 'yianwillis/vimcdoc'

"  主题
Plug 'sainnhe/sonokai'
"  airline
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

" airline
let g:airline_theme = 'sonokai'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#buffer_nr_show = 1



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




