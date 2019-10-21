" Vim: set fdm=marker fmr={{{,}}} fdl=0 fdls=-1:

" Plugins {{{
call plug#begin('~/.vim/plugged')
            
Plug 'aymericbeaumet/vim-symlink'
Plug 'bfrg/vim-cpp-modern'
Plug 'bkad/CamelCaseMotion'
Plug 'crusoexia/vim-monokai'
Plug 'dense-analysis/ale'
Plug 'easymotion/vim-easymotion'
Plug 'editorconfig/editorconfig-vim'
Plug 'glts/vim-magnum'
Plug 'glts/vim-radical'
Plug 'janko/vim-test'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'justinmk/vim-sneak'
Plug 'moll/vim-bbye' 
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'pelodelfuego/vim-swoop'
Plug 'rhysd/vim-clang-format'
Plug 'scrooloose/nerdtree'
Plug 'tommcdo/vim-exchange'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-airline/vim-airline'
Plug 'wellle/targets.vim'

call plug#end()
" }}}

" Facebook {{{
source $LOCAL_ADMIN_SCRIPTS/master.vimrc
source $ADMIN_SCRIPTS/vim/biggrep.vim

" coc
let g:coc_node_path = expand("/data/users/$USER/fbsource/xplat/third-party/node/bin/node")
let g:coc_filetype_map = {'cc': 'cpp'}

" biggrep
let repo_path = system('hg root')
let repo_initial = 'f'
if repo_path =~# 'configerator'
  let repo_initial = 'c'
elseif repo_path =~# 'www'
  let repo_initial = 't'
elseif repo_path =~# 'fbcode'
  let repo_initial = 'f'
endif

command! -bang -nargs=* Bg
      \ call fzf#vim#grep(
      \   repo_initial . 'bgs --color=on '.shellescape(<q-args>) .
      \ '| sed "s,^[^/]*/,,"' .
      \ '| sed "s#^#$(hg root)/#g"', 1,
      \   <bang>0 ? fzf#vim#with_preview('up:60%')
      \           : fzf#vim#with_preview('up:55%:hidden', '?'),
      \   <bang>0)

noremap gs :Bg <C-r><C-w><CR>

" buck
nnoremap <Leader>bb :Dispatch buck build $(buck query "owner('$(realpath %)')" \| head -1) \| cat<CR>
nnoremap <Leader>bt :Dispatch buck test $(buck query "owner('$(realpath %)')" \| head -1) \| cat<CR>
" }}}

" Colors {{{
if !has('gui_running')
  set t_Co=256
endif
if (match($TERM, "-256color") != -1) && (match($TERM, "screen-256color") == -1)
  " screen does not (yet) support truecolor
  set termguicolors
endif

colorscheme monokai
set bg=dark
" }}}

" Settings {{{
set hidden
set number
set autoread
set clipboard=unnamed
set noswapfile
set ignorecase
set smartcase
set cursorline
set mouse=a
set incsearch
set ignorecase
set smartcase
set gdefault
" }}}

" Keybindings {{{
let mapleader=" "

" Copy & paste to system clipboard with <Space>p and <Space>y:
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

" Jump to start and end of line using the home row keys
map H ^
map L $

nnoremap <M-o> <C-W>w
nnoremap <M-0> <C-W>c
nnoremap <M-1> <C-W>o
nnoremap <M-2> <C-W>s
nnoremap <M-3> <C-W>v
nnoremap <C-k> :Bdelete<CR>

nnoremap <Leader>C :ClangFormatAutoToggle<CR>
nnoremap <leader>s :w<CR>
nnoremap <leader>S :ClangFormat<CR>:w<CR>
nnoremap <leader>q :e ~/.vimrc<CR>
nnoremap <leader>qw :w<CR>:source ~/.vimrc<CR>
nnoremap <leader>qe :w<CR>:source ~/.vimrc<CR>:PlugInstall<CR>
nnoremap <leader>qr :PlugClean!<CR>
nnoremap <leader>t <C-O>

" Left and right can switch buffers
nnoremap <left> :bp<CR>
nnoremap <right> :bn<CR>

" <leader><leader> toggles between buffers
nnoremap <leader><leader> <c-^>

" Open new file adjacent to current file
nnoremap <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" easymotion
let g:EasyMotion_smartcase = 1
let g:EasyMotion_do_mapping = 0

" Use tab for trigger completion with characters ahead and navigate.
" " Use command ':verbose imap <tab>' to make sure tab is not mapped by other
" plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" myc
set rtp+=/usr/local/share/myc/vim
nnoremap <leader>j :MYC<CR>

" NERDTree
nnoremap <leader>d :NERDTreeToggle<CR>
nnoremap <leader>D :NERDTreeFind<CR>

" ALE
nnoremap <leader>k :ALEGoToDefinition<CR>
nnoremap <leader>K :ALEGoToDefinitionInVSplit<CR>

" fzf
nnoremap <leader>f :Files<CR>
nnoremap <leader>i :History<CR>
nnoremap <silent> <C-a> :BLines<CR>
nnoremap <leader>? :Rg<CR>
nnoremap <leader>rg :Rg <C-R><C-W><CR>
nnoremap <leader>l :BTags<CR>
nnoremap <C-P> :Commands<CR>

function! s:list_cmd()
  let base = fnamemodify(expand('%'), ':h:.:S')
  return base == '.' ? 'fd --type file --follow' : printf('fd --type file --follow | proximity-sort %s', shellescape(expand('%')))
endfunction

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, {'source': s:list_cmd(),
  \                               'options': '--tiebreak=index'}, <bang>0)

" fugitive
nnoremap <leader>g :G<CR>
" }}}
