if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'aymericbeaumet/vim-symlink'
Plug 'cespare/vim-toml'
Plug 'christoomey/vim-tmux-navigator'            
Plug 'editorconfig/editorconfig-vim'
Plug 'folke/tokyonight.nvim'
Plug 'glts/vim-magnum'
Plug 'glts/vim-radical'
Plug 'hrsh7th/nvim-compe'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'justinmk/vim-dirvish'
Plug 'moll/vim-bbye' 
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/lsp_extensions.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'ojroques/vim-oscyank'
Plug 'psf/black'
Plug 'rhysd/vim-clang-format'
Plug 'terryma/vim-expand-region'
Plug 'tommcdo/vim-exchange'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vhdirk/vim-cmake'
Plug 'vim-utils/vim-man'
Plug 'wellle/targets.vim'
Plug 'windwp/nvim-autopairs'
Plug 'ziglang/zig.vim'

call plug#end()

let mapleader=" "

if system("hostname") =~ "facebook"
  source $LOCAL_ADMIN_SCRIPTS/master.vimrc
  source $ADMIN_SCRIPTS/vim/biggrep.vim
  set rtp+=/usr/local/share/myc/vim
  nnoremap <leader>j :MYC<CR>
endif

set termguicolors
set t_Co=256 
if !has('nvim')
  set term=xterm-256color
endif
colorscheme tokyonight

let g:lightline = { 'colorscheme': 'tokyonight' }

set completeopt=menuone,noinsert,noselect
set cursorline
set hidden
set hlsearch
set ignorecase
set mouse=a
set noswapfile
set number
set shortmess+=c
set signcolumn=number
set smartcase
set tabstop=8
set signcolumn=number

nnoremap <C-k> <Esc>
inoremap <C-k> <Esc>
vnoremap <C-k> <Esc>
snoremap <C-k> <Esc>
xnoremap <C-k> <Esc>
cnoremap <C-k> <Esc>
onoremap <C-k> <Esc>
lnoremap <C-k> <Esc>
tnoremap <C-k> <Esc>

" Ctrl+h to stop searching
vnoremap <C-h> :nohlsearch<CR>
nnoremap <C-h> :nohlsearch<CR>

" Copy text to the system clipboard from anywhere using the ANSI OCS52 sequence
vnoremap <leader>c :OSCYank<CR>

" Keymap for replacing up to next _ or -
noremap <leader>m ct_
noremap <leader>n ct-

nnoremap <C-c> :Bdelete<CR>

" expand region
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" ergonomic save
nnoremap <leader>s :w<CR>
" save no autocmds
nnoremap <leader>w :noa w<CR>
"
" cd vim working directory to that of the current file
nnoremap <leader>cd :cd %:p:h<CR>

" .vimrc
nnoremap <leader>.. :e ~/.vimrc<CR>
nnoremap <leader>., :w<CR>:source ~/.vimrc<CR>
nnoremap <leader>.m :w<CR>:source ~/.vimrc<CR>:PlugInstall<CR>
nnoremap <leader>.n :PlugClean!<CR>
nnoremap <leader>.b :PlugUpdate<CR>

" <leader><leader> toggles between buffers
nnoremap <leader><leader> <c-^>

" Open new file adjacent to current file
nnoremap <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" man word under cursor
nnoremap <leader>M :Man <C-R><C-W><CR>

" Dirvish
nnoremap <leader>d :Dirvish %<CR>

" Clap
nnoremap <leader>f <cmd>Telescope find_files<CR>
nnoremap <leader>F <cmd>Telescope file_browser<CR>
nnoremap <leader>l <cmd>Telescope buffers<CR>
nnoremap <leader>L <cmd>Telescope oldfiles<CR>
nnoremap <leader>/ <cmd>Telescope live_grep<CR>
nnoremap <leader>? <cmd>Telescope grep_string<CR>
nnoremap <leader>i <cmd>Telescope treesitter<CR>
nnoremap <leader>x <cmd>Telescope commands<CR>

" fugitive
nnoremap <leader>gg :G<CR>
nnoremap <leader>gp :Git push<CR>
nnoremap <leader>gf :Git pull --rebase<CR>

" tmux navigator
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <C-g>h :TmuxNavigateLeft<CR>
nnoremap <silent> <C-g>j :TmuxNavigateDown<CR>
nnoremap <silent> <C-g>k :TmuxNavigateUp<CR>
nnoremap <silent> <C-g>l :TmuxNavigateRight<CR>
nnoremap <silent> <C-g>\ :TmuxNavigatePrevious<CR>

autocmd BufWritePre *.py :Black
autocmd BufWritePre *.{c,cpp,h} :ClangFormat

lua <<EOF
require'nvim-autopairs'.setup()

require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
    disable = { "rust" },
  },
}

require'lspconfig'.rust_analyzer.setup{}

require'compe'.setup({
enabled = true,
source = {
  path = true,
  buffer = true,
  nvim_lsp = true,
  },
})

local remap = vim.api.nvim_set_keymap
local npairs = require('nvim-autopairs')

-- skip it, if you use another global object
_G.MUtils= {}

vim.g.completion_confirm_key = ""
MUtils.completion_confirm=function()
  if vim.fn.pumvisible() ~= 0  then
    if vim.fn.complete_info()["selected"] ~= -1 then
      return vim.fn["compe#confirm"](npairs.esc("<cr>"))
    else
      return npairs.esc("<cr>")
    end
  else
    return npairs.autopairs_cr()
  end
end


remap('i' , '<CR>','v:lua.MUtils.completion_confirm()', {expr = true , noremap = true})
EOF

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

nnoremap <leader>T :lua require'lsp_extensions'.inlay_hints()<CR>
nmap <silent> E <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nmap <silent> W <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
nmap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nmap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nmap <silent> gR <cmd>lua vim.lsp.buf.rename()<CR>
nmap <silent> ga <cmd>lua vim.lsp.buf.code_action()<CR>

autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 1000)
