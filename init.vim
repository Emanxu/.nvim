" __  ____   __  _   ___     _____ __  __ ____   ____
"|  \/  \ \ / / | \ | \ \   / /_ _|  \/  |  _ \ / ___|
"| |\/| |\ V /  |  \| |\ \ / / | || |\/| | |_) | |
"| |  | | | |   | |\  | \ V /  | || |  | |  _ <| |___
"|_|  |_| |_|   |_| \_|  \_/  |___|_|  |_|_| \_\\____|

" Author: @xxc



" ==================== Auto load for first time uses ====================
if empty(glob($HOME.'/.config/nvim/autoload/plug.vim'))
	silent !curl -fLo $HOME/.config/nvim/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


let g:plug_window = '-tabnew'
let g:plug_pwindow = 'vertical rightbelow new'

" ==================== Editor behavior ====================
filetype on
set nocompatible
filetype plugin on
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
set scrolloff=5
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
set colorcolumn=100
set updatetime=100
set virtualedit=block

" ==================== Basic Mappings ====================
let mapleader=" "
" Open the vimrc file anytime
"nnoremap <LEADER>rc :e $HOME/.config/nvim/init.vim<CR>
nnoremap <LEADER>rc :e $MYVIMRC<CR>
" reflash the vimrc file anytime
nnoremap <LEADER>sv :so $MYVIMRC<CR>

" Search 正常模式下按 空格+回车 取消高亮显示 
nnoremap <LEADER><CR> :nohlsearch<CR>


" 插入模式下上下左右的映射
inoremap <A-h> <left>
inoremap <A-l> <right>
inoremap <A-j> <down>
inoremap <A-k> <up>

" buffer 相关
nnoremap ,b :ls<CR>
nnoremap ,n :bnext<CR>
nnoremap ,m :bprevious<CR>

" tab 相关
nnoremap ,N :tabnext<CR>
nnoremap ,M :tabprevious<CR>


" ==================== Plug install ====================
call plug#begin('~/.config/nvim/plugged')
"  中文文档
Plug 'yianwillis/vimcdoc'

"=====junegunn家插件
" help for vim-plug
Plug 'junegunn/vim-plug'
"  主题
Plug 'theniceboy/nvim-deus'
" fzf finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" 粘贴板历史
Plug 'junegunn/vim-peekaboo'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/vim-emoji'
"==================
"  状态栏
Plug 'itchyny/lightline.vim'

"  coc.nvim
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Undo Tree
Plug 'mbbill/undotree'

" markdown 
"  如果出现报错,nvim包里面执行yarn install 然后回来重装即可
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install',
																			\'for': ['markdown', 'vimwiki'], 'on': 'MarkdownPreview' }
" 自动序列
Plug 'dkarter/bullets.vim'
Plug 'mzlogin/vim-markdown-toc',{'for': ['markdown', 'vimwiki'] }
Plug 'vimwiki/vimwiki'
Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeToggle', 'for': ['text', 'markdown', 'vim-plug'] }

" git相关
Plug 'airblade/vim-gitgutter'

" vista 大纲工具 依赖coc等lsp支持
Plug 'liuchengxu/vista.vim',{'on': 'Vista'}

" nvim-treesitter/nvim-treesitter
" require gcc-c++ and libstdc++ on your system 
Plug 'nvim-treesitter/nvim-treesitter'
call plug#end()


" ==================== 皮肤和状态栏 ====================
"set termguicolors " enable true colors support
if has('termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

let $NVIM_TUI_ENABLE_TRUE_COLOR=1
silent! color deus
hi NonText ctermfg=gray guifg=grey10

" ==================== statusline ==================
" 3: always and ONLY the last window
set laststatus=3

let g:lightline = {
\ 'colorscheme': 'deus',
\ 'active': {
\   'left': [ [ 'mode', 'paste' ],
\             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
\ },
\ 'component_function': {
\   'cocstatus': 'coc#status'
\ },
\ }
" Use autocmd to force lightline update.
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

" ==================== coc.nvim====================
let g:coc_global_extensions = [
			\ 'coc-json',
			\ 'coc-vimlsp',
			\ 'coc-pyright',
			\ 'coc-explorer',
			\ 'coc-lists',
			\ 'coc-yank']
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

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-@> coc#refresh()

" ==================== Undotree ====================
noremap L :UndotreeToggle<CR>
let g:undotree_WindowLayout = 2
let g:undotree_ShortIndicators = 1
let g:undotree_SplitWidth = 24
let g:undotree_DiffAutoOpen = 1
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_DiffpanelHeight = 8
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


" =================== coc-nvim map ==============
nnoremap tt :CocCommand explorer<CR>
" yank map
nnoremap <silent> <LEADER><LEADER>y  :<C-u>CocList -A --normal yank<CR>
nnoremap <silent> <LEADER><LEADER>b  :<C-u>CocList -A --normal buffers<CR>

" ==================== Markdown Settings ====================
" =================== preview  ==========
" specify browser to open preview page
" for path with space
" valid: `/path/with\ space/xxx`
" invalid: `/path/with\\ space/xxx`
" default: ''
let g:mkdp_browser = 'firefox'


"======================== vim-table-mode ==============================
nnoremap <LEADER>tm :TableModeToggle<CR>


" ==================== Bullets.vim ====================
" Bullets.vim
let g:bullets_enabled_file_types = [
	\ 'markdown',
	\ 'text',
	\ 'gitcommit',
	\ 'scratch'
	\]

" Snippets ============================================
source $HOME/.config/nvim/md-snippets.vim

"===================== vimwiki ========================
let g:vimwiki_list = [
	\ {'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'},
	\ {'path': '~/wiki_CPA/tax/', 'syntax': 'markdown', 'ext': '.md'},
	\ {'path': '~/wiki_CPA/account/', 'syntax': 'markdown', 'ext': '.md'},
	\ {'path': '~/wiki_CPA/audit/', 'syntax': 'markdown', 'ext': '.md'},
	\]

let g:vimwiki_listsyms = '✗○◐●✓'
nnoremap <LEADER>wl :VimwikiToggleListItem<CR>

" ==================== vim-markdown-toc ====================
let g:vmt_cycle_list_item_markers = 1
let g:vmt_fence_text = 'TOC'
let g:vmt_fence_closing_text = '/TOC'


" ==================== GitGutter ====================
let g:gitgutter_sign_allow_clobber = 0
let g:gitgutter_map_keys = 0
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_preview_win_floating = 1
let g:gitgutter_sign_added = emoji#for('small_blue_diamond')
let g:gitgutter_sign_modified = emoji#for('small_orange_diamond')
let g:gitgutter_sign_removed = emoji#for('small_red_triangle')
let g:gitgutter_sign_removed_first_line = '羅'
let g:gitgutter_sign_modified_removed = emoji#for('collision')
nnoremap <LEADER>gf :GitGutterFold<CR>
nnoremap H :GitGutterPreviewHunk<CR>
nnoremap <LEADER>g- :GitGutterPrevHunk<CR>
nnoremap <LEADER>g= :GitGutterNextHunk<CR>

" ======================= vista.vim =======
" How each level is indented and what to prepend.
" This could make the display more compact or more spacious.
" e.g., more compact: ["▸ ", ""]
" Note: this option only works for the kind renderer, not the tree renderer.
"let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]

" Executive used when opening vista sidebar without specifying it.
" See all the avaliable executives via `:echo g:vista#executives`.
let g:vista_default_executive = 'coc'
let g:vista_sidebar_open_cmd = '30vsplit'
let g:vista_cursor_delay = 50
let g:vista_echo_cursor_strategy = 'scroll'

" Set the executive for some filetypes explicitly. Use the explicit executive
" instead of the default one for these filetypes when using `:Vista` without
" specifying the executive.
let g:vista_executive_for = {
  \ 'cpp': 'vim_lsp',
  \ 'php': 'vim_lsp',
  \ 'vimwiki': 'markdown',
	\ 'markdown': 'toc',
  \ }

" To enable fzf's preview window set g:vista_fzf_preview.
" The elements of g:vista_fzf_preview will be passed as arguments to fzf#vim#with_preview()
" For example:
let g:vista_fzf_preview = ['right:50%']

" Ensure you have installed some decent font to show these pretty symbols, then you can enable icon for the kind.
let g:vista#renderer#enable_icon = 1

" The default icons can't be suitable for all the filetypes, you can extend it as you wish.
let g:vista#renderer#icons = {
\   "function": "\uf794",
\   "variable": "\uf71b",
\  }

let g:vista_update_on_text_changed=1
" change vista highlinght
"hi VistaFloat ctermbg=237 guibg=#3a3a3a

" ==================== nvim-treesitter ===========================
lua <<EOF
require("nvim-treesitter.install").prefer_git = true
require'nvim-treesitter.configs'.setup {
	-- one of "all", "language", or a list of languages
	ensure_installed = {"vim", "python", "json", "c", "bash", "go","lua","markdown"},
	highlight = {
		enable = true,              -- false will disable the whole extension
		disable = { "rust" },  -- list of language that will be disabled
	},
}
EOF

"=====================fzf.vim==============
"Dependencies
"
"    fzf 0.23.0 or above
"    For syntax-highlighted preview, install bat
"    If delta is available, GF?, Commits and BCommits will use it to format git diff output.
"    Ag requires The Silver Searcher (ag)
"    Rg requires ripgrep (rg)
"    Tags and Helptags require Perl
"-----------------------------------------
" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }
" - Popup window (center of the screen)
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
" [[B]Commits] Customize the options used by 'git log':
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

" All files
command! -nargs=? -complete=dir AF
  \ call fzf#run(fzf#wrap(fzf#vim#with_preview({
  \   'source': 'fd --type f --hidden --follow --exclude .git --no-ignore . '.expand(<q-args>)
  \ })))


" ================================ 好用的脚本 ============================

" 记录上一次文件修改光标的位置
augroup resCur
  autocmd!
  autocmd BufReadPost * call setpos(".", getpos("'\""))
augroup END

" =================== Compile function ==========

" Compile function
nnoremap <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
	exec "w"
	if &filetype == 'python'
		set splitbelow
		:sp
		:term python3 %
	elseif &filetype == 'sh'
		:!time bash %
	elseif &filetype == 'markdown'
		exec "MarkdownPreview"
	elseif &filetype == 'vimwiki'
		exec "MarkdownPreview"
	elseif &filetype == 'go'
		set splitbelow
		:sp
		:term go run .
	endif
endfunc

" ================= file test function ===============
nnoremap == :call File_test()<CR>
func! File_test()
	exec "w"
	if &filetype == 'vimwiki'
		setlocal syntax=markdown
	endif
endfunc
