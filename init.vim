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
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.1' }
Plug 'neovim/nvim-lspconfig'

call plug#end()

nnoremap <C-f> :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>

nnoremap <C-p> :Telescope find_files<CR>
"nnoremap <leader>f :Telescope live_grep<CR>

lua << EOF
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>f', function() builtin.grep_string({ search = vim.fn.input('Grep > ') }) end)
EOF

" copy to clipboard in visual mode
vnoremap <C-c> "+y

nnoremap <S-l> :BufferLineCycleNext<CR>
nnoremap <S-h> :BufferLineCyclePrev<CR>

" shortcut to close the current buffer
nnoremap <leader>q :bdelete<CR>

nnoremap <F7> :FloatermNew --wintype=normal --width=0.8 --height=0.8 --position=bottom lazygit<CR>
nnoremap <F6> :FloatermNew --wintype=normal --width=0.8 --height=0.8 --position=bottom<CR>

nmap <F8> :TagbarToggle<CR>
nmap <silent> gd <Plug>(coc-definition)

" nvim-treesitter
lua << EOF
    require'nvim-treesitter.configs'.setup {
        ensure_installed = { "javascript", "typescript", "tsx", "html", "css", "json", "lua", "python", "bash", "c", "cpp", "java", "go", "rust", "toml", "yaml", "jsonc", "regex", "graphql", "php", "ruby", "vue", "vim"},

        sync_install = true,

        auto_install = true,

        highlight = {
            enable = true,
        },
    }
EOF

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
colorscheme dracula

lua << EOF
    require("bufferline").setup{}

    vim.api.nvim_set_hl(0, "Normal", {bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", {bg = "none" })

EOF

let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="~"

let g:LanguageClient_serverCommands = {
\ 'rust': ['rust-analyzer'],
\ }

" NERDTree settings show . hidden files
let NERDTreeShowHidden=1

lua << EOF
    local nvim_lsp = require'lspconfig'

    nvim_lsp.rust_analyzer.setup({
        on_attach=on_attach,
        settings = {
            ["rust-analyzer"] = {
                imports = {
                    granularity = {
                        group = "module",
                    },
                    prefix = "self",
                },
                cargo = {
                    buildScripts = {
                        enable = true,
                    },
                },
                procMacro = {
                    enable = true
                },
            }
        }
    })
    nvim_lsp.intelephense.setup({
        on_attach=on_attach,
        settings = {
            intelephense = {
                environment = {
                    phpVersion = "8.0"
                },
                stubs = {
                    bundled = true,
                    composer = true,
                    extensions = true,
                    "wordpress",
                    "laravel",
                    "codeigniter",
                    "perfex_crm",
                }
            }
        }
    })
EOF
