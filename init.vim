:set number
:set relativenumber
:set autoindent
:set expandtab
:set tabstop=4
:set shiftwidth=4
:set smarttab
:set softtabstop=4
:set mouse=a
set redrawtime=10000

call plug#begin()

Plug 'http://github.com/tpope/vim-surround'
Plug 'https://github.com/preservim/nerdtree'
Plug 'https://github.com/tpope/vim-commentary'
Plug 'https://github.com/vim-airline/vim-airline'
Plug 'https://github.com/ap/vim-css-color'
Plug 'https://github.com/rafi/awesome-vim-colorschemes'
Plug 'https://github.com/ryanoasis/vim-devicons'
Plug 'https://github.com/tc50cal/vim-terminal'
Plug 'https://github.com/terryma/vim-multiple-cursors'
Plug 'https://github.com/preservim/tagbar'
Plug 'https://github.com/neoclide/coc.nvim'
Plug 'https://github.com/github/copilot.vim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'akinsho/bufferline.nvim', { 'tag': 'v2.*' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'voldikss/vim-floaterm'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'antoinemadec/FixCursorHold.nvim'
Plug 'tribela/vim-transparent'
Plug 'sbdchd/neoformat'
Plug 'prettier/vim-prettier', { 'do': 'yarn install --frozen-lockfile --production' }
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'bluz71/vim-nightfly-guicolors'
Plug 'glepnir/dashboard-nvim'
Plug 'EdenEast/nightfox.nvim'

call plug#end()

nnoremap <C-f> :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>

nnoremap <C-p> :FZF<CR>
nnoremap <leader>f :Rg<CR>
nnoremap <S-l> :BufferLineCycleNext<CR>
nnoremap <S-h> :BufferLineCyclePrev<CR>

" shortcut to close the current buffer
nnoremap <leader>q :bdelete<CR>

nnoremap <F7> :FloatermNew --wintype=normal --width=0.8 --height=0.8 --position=bottom lazygit<CR>
nnoremap <F6> :FloatermNew --wintype=normal --width=0.8 --height=0.8 --position=bottom<CR>

nmap <F8> :TagbarToggle<CR>
nmap <silent> gd <Plug>(coc-definition)

" split keybindings
set splitbelow splitright
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" shortcut to vsplit
nnoremap <leader>v :vsplit<CR>

" shortcut prettier partial
nnoremap <leader>p :PrettierPartial<CR>
" shortcut prettier
nnoremap <leader>P :Prettier<CR>


" shortcut to comment out highlighted text
vnoremap <leader>c :Commentary<CR>

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

if has('nvim')
	inoremap <silent><expr> <c-space> coc#refresh()
else
	inoremap <silent><expr> <c-@> coc#refresh()
endif

nmap <leader>cl  <Plug>(coc-codelens-action)

set rtp+=~/.fzf

syntax on
set t_Co=256

" set termguicolors
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" theme settings
syntax on
set t_Co=256
set cursorline
colorscheme nightfly

lua << EOF
require("bufferline").setup{}
EOF

let NerdTreeShowHidden=1

let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="~"

" Configure dashboard-nvim with ffz
let g:dashboard_default_executive = 'telescope'
nnoremap <silent> <Leader>fh :DashboardFindHistory<CR>
nnoremap <silent> <Leader>ct :DashboardChangeColorscheme<CR>
nnoremap <silent> <Leader>fm :DashboardJumpMark<CR>
nnoremap <silent> <Leader>nf :DashboardNewFile<CR>

