" Vim: set fdm=marker fmr={{{,}}} fdl=1 fdls=-1:

" Plugins {{{
call plug#begin('~/.vim/plugged')

Plug 'aymericbeaumet/vim-symlink'
Plug 'christoomey/vim-tmux-navigator'            
Plug 'dense-analysis/ale'
Plug 'editorconfig/editorconfig-vim'
Plug 'elixir-editors/vim-elixir'
Plug 'glts/vim-magnum'
Plug 'glts/vim-radical'
Plug 'itchyny/lightline.vim'
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
Plug 'wellle/targets.vim'

call plug#end()
" }}}

let mapleader=" "

" Facebook {{{
if system("hostname") =~ "facebook"
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
set clipboard+=unnamedplus
set noswapfile
set ignorecase
set smartcase
set cursorline
set mouse=a
set incsearch
set ignorecase
set smartcase
set gdefault
set colorcolumn=80 " give me a colored column
" }}}

" Keybindings {{{
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

nnoremap <M-o> <C-W>w
nnoremap <M-0> <C-W>c
nnoremap <M-1> <C-W>o
nnoremap <M-2> <C-W>s
nnoremap <M-3> <C-W>v
nnoremap <C-c> :Bdelete<CR>

" expand region
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" ergonomic save
nnoremap <leader>s :w<CR>

" cd vim working directory to that of the current file
nnoremap <leader>cd :cd %:p:h<CR>

" .vimrc
nnoremap <leader>.. :e ~/.vimrc<CR>
nnoremap <leader>., :w<CR>:source ~/.vimrc<CR>
nnoremap <leader>.m :w<CR>:source ~/.vimrc<CR>:PlugInstall<CR>
nnoremap <leader>.n :PlugClean!<CR>

" <leader><leader> toggles between buffers
nnoremap <leader><leader> <c-^>

" Open new file adjacent to current file
nnoremap <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" man word under cursor
nnoremap <leader>M :Man <C-R><C-W><CR>

"rust
let g:rustfmt_autosave = 1

" coc
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

nmap <silent> E <Plug>(coc-diagnostic-prev)
nmap <silent> W <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gR <Plug>(coc-rename)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" lightline
let g:lightline = {
  \ 'colorscheme': 'one',
  \ }

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
nnoremap <leader>l :Buffers<CR>
nnoremap <leader>L :History<CR>
nnoremap <leader>/ :Rg<CR>
nnoremap <leader>? :Rg <C-R><C-W><CR>
nnoremap <leader>i :BTags<CR>
nnoremap <leader>x :Commands<CR>

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

nmap <F8> <Plug>(ale_fix)
let g:ale_fixers = {
\   'c': [
\       'clang-format'
\   ],
\   'cpp': [
\       'clang-format'
\   ],
\}

" tmux navigator
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <C-g>h :TmuxNavigateLeft<CR>
nnoremap <silent> <C-g>j :TmuxNavigateDown<CR>
nnoremap <silent> <C-g>k :TmuxNavigateUp<CR>
nnoremap <silent> <C-g>l :TmuxNavigateRight<CR>
nnoremap <silent> <C-g>\ :TmuxNavigatePrevious<CR>

" Z - cd to recent / frequent directories
command! -nargs=* Z :call Z(<f-args>)
function! Z(...)
  let cmd = 'fasd -d -e printf'
  for arg in a:000
    let cmd = cmd . ' ' . arg
  endfor
  let path = system(cmd)
  if isdirectory(path)
    echo path
    exec 'cd' fnameescape(path)
  endif
endfunction
