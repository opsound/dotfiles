if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'arcticicestudio/nord-vim'
Plug 'aymericbeaumet/vim-symlink'
Plug 'cespare/vim-toml'
Plug 'christoomey/vim-tmux-navigator'            
Plug 'editorconfig/editorconfig-vim'
Plug 'glts/vim-magnum'
Plug 'glts/vim-radical'
Plug 'itchyny/lightline.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'justinmk/vim-dirvish'
Plug 'justinmk/vim-sneak'
Plug 'justinmk/vim-syntax-extra'
Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary' }
Plug 'liuchengxu/vista.vim'
Plug 'moll/vim-bbye' 
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
Plug 'rhysd/vim-clang-format'
Plug 'rust-lang/rust.vim'
Plug 'terryma/vim-expand-region'
Plug 'tommcdo/vim-exchange'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'vhdirk/vim-cmake'
Plug 'vim-utils/vim-man'
Plug 'wellle/targets.vim'
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
colorscheme nord

let g:lightline = { 'colorscheme': 'nord' }

set hlsearch
set hidden
set number
set noswapfile
set cursorline
set mouse=a
set ignorecase
set smartcase
set tabstop=8

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

" Copy & paste to system clipboard with <Space>p and <Space>y:
vmap <leader>y "+y
nmap <leader>p "+p
nmap <leader>P "+P
vmap <leader>p "+p
vmap <leader>P "+P

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

"rust
let g:rustfmt_autosave = 1

nmap <silent> E <Plug>(coc-diagnostic-prev)
nmap <silent> W <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gR <Plug>(coc-rename)

" sneak
" ignore case
let g:sneak#use_ic_scs = 1 

" Dirvish
nnoremap <leader>d :Dirvish %<CR>

" Clap
nnoremap <leader>S :Clap blines ++ef=maple +async<CR>
nnoremap <leader>f :Clap files ++ef=maple +async<CR>
nnoremap <leader>F :Clap filer<CR>
nnoremap <leader>l :Clap buffers<CR>
nnoremap <leader>L :Clap history<CR>
nnoremap <leader>J :Clap jumps<CR>
nnoremap <leader>/ :Clap grep<CR>
nnoremap <leader>? :Clap grep ++query=<cword><CR>a<BS>
nnoremap <leader>i :Clap tags<CR>
nnoremap <leader>x :Commands<CR>
nnoremap <leader>h :Clap blines<CR>

" fugitive
nnoremap <leader>gg :G<CR>
nnoremap <leader>gp :Gpush<CR>
nnoremap <leader>gf :Gpull<CR>

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" tmux navigator
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <C-g>h :TmuxNavigateLeft<CR>
nnoremap <silent> <C-g>j :TmuxNavigateDown<CR>
nnoremap <silent> <C-g>k :TmuxNavigateUp<CR>
nnoremap <silent> <C-g>l :TmuxNavigateRight<CR>
nnoremap <silent> <C-g>\ :TmuxNavigatePrevious<CR>
