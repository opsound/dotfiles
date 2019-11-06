" Vim: set fdm=marker fmr={{{,}}} fdl=1 fdls=-1:

" Plugins {{{
call plug#begin('~/.vim/plugged')
            
Plug 'aymericbeaumet/vim-symlink'
Plug 'dense-analysis/ale'
Plug 'editorconfig/editorconfig-vim'
Plug 'glts/vim-magnum'
Plug 'glts/vim-radical'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'justinmk/vim-dirvish'
Plug 'justinmk/vim-sneak'
Plug 'justinmk/vim-syntax-extra'
Plug 'moll/vim-bbye' 
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'rakr/vim-one'
Plug 'tommcdo/vim-exchange'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'wellle/targets.vim'

call plug#end()
" }}}

let mapleader=" "

" Facebook {{{
if system("name") =~ "facebook"
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
  nnoremap <leader>bb :Dispatch buck build $(buck query "owner('$(realpath %)')" \| head -1) \| cat<CR>
  nnoremap <leader>bt :Dispatch buck test $(buck query "owner('$(realpath %)')" \| head -1) \| cat<CR>
  
  " myc
  set rtp+=/usr/local/share/myc/vim
  nnoremap <leader>j :MYC<CR>
endif
" }}}

" Colors {{{
"Credit joshdick
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (has("nvim"))
"For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

set termguicolors
set background=dark
colorscheme one
" }}}

" Settings {{{
set hlsearch
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

nnoremap <silent> <C-l> :nohl<CR><C-l>

" Copy & paste to system clipboard with <Space>p and <Space>y:
vmap <leader>y "+y
nmap <leader>p "+p
nmap <leader>P "+P
vmap <leader>p "+p
vmap <leader>P "+P

nnoremap <M-o> <C-W>w
nnoremap <M-0> <C-W>c
nnoremap <M-1> <C-W>o
nnoremap <M-2> <C-W>s
nnoremap <M-3> <C-W>v
nnoremap <C-k> :Bdelete<CR>

nnoremap <leader>C :ClangFormatAutoToggle<CR>
nnoremap <leader>s :w<CR>
nnoremap <leader>S :ClangFormat<CR>:w<CR>
nnoremap <leader>cd :cd %:p:h<CR>

" .vimrc
nnoremap <leader>.. :e ~/.vimrc<CR>
nnoremap <leader>., :w<CR>:source ~/.vimrc<CR>
nnoremap <leader>.m :w<CR>:source ~/.vimrc<CR>:PlugInstall<CR>
nnoremap <leader>.n :PlugClean!<CR>

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

" sneak
" ignore case
let g:sneak#use_ic_scs = 1 

" Dirvish
nnoremap <leader>d :Dirvish %<CR>

" ALE
nnoremap <silent><leader>k :ALEGoToDefinition<CR>
nnoremap <silent><leader>K :ALEGoToDefinitionInVSplit<CR>

" fzf
nnoremap <leader>f :Files<CR>
nnoremap <leader>i :History<CR>
nnoremap <leader>? :Rg<CR>
nnoremap <leader>rg :Rg <C-R><C-W><CR>
nnoremap <leader>l :BTags<CR>
nnoremap <leader>x :Commands<CR>
nnoremap <C-P> :Commands<CR>

function! s:list_cmd()
  let base = fnamemodify(expand('%'), ':h:.:S')
  return base == '.' ? 'fd --type file --follow' : printf('fd --type file --follow | proximity-sort %s', shellescape(expand('%')))
endfunction

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, {'source': s:list_cmd(),
  \                               'options': '--tiebreak=index'}, <bang>0)

" fugitive
nnoremap <leader>gg :G<CR>
nnoremap <leader>gp :Gpush<CR>
nnoremap <leader>gf :Gpull<CR>
" }}}
