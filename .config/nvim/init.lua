local function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end

require("packer").startup(function(use)
  use({ "Chiel92/vim-autoformat" })
  use({ "alexghergh/nvim-tmux-navigation" })
  use({ "aymericbeaumet/vim-symlink" })
  use({ "cespare/vim-toml" })
  use({ "ckipp01/stylua-nvim" })
  use({ "editorconfig/editorconfig-vim" })
  use({ "folke/lua-dev.nvim" })
  use({ "folke/tokyonight.nvim" })
  use({ "glts/vim-magnum" })
  use({ "glts/vim-radical" })
  use({ "hoob3rt/lualine.nvim" })
  use({ "hrsh7th/cmp-buffer" })
  use({ "hrsh7th/cmp-cmdline" })
  use({ "hrsh7th/cmp-nvim-lsp" })
  use({ "hrsh7th/cmp-path" })
  use({ "hrsh7th/cmp-vsnip" })
  use({ "hrsh7th/nvim-cmp" })
  use({ "hrsh7th/vim-vsnip" })
  use({ "ibhagwan/fzf-lua" })
  use({ "justinmk/vim-dirvish" })
  use({ "kyazdani42/nvim-web-devicons" })
  use({ "moll/vim-bbye" })
  use({ "neovim/nvim-lspconfig" })
  use({ "numToStr/Comment.nvim" })
  use({ "nvim-lua/lsp-status.nvim" })
  use({ "nvim-lua/lsp_extensions.nvim" })
  use({ "nvim-lua/plenary.nvim" })
  use({ "nvim-lua/popup.nvim" })
  use({ "nvim-telescope/telescope.nvim" })
  use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
  use({ "ojroques/vim-oscyank" })
  use({ "psf/black" })
  use({ "rhysd/vim-clang-format" })
  use({ "tommcdo/vim-exchange" })
  use({ "tpope/vim-dispatch" })
  use({ "tpope/vim-repeat" })
  use({ "tpope/vim-surround" })
  use({ "vhdirk/vim-cmake" })
  use({ "vijaymarupudi/nvim-fzf" })
  use({ "wbthomason/packer.nvim" })
  use({ "wellle/targets.vim" })
  use({ "windwp/nvim-autopairs" })
  use({ "ziglang/zig.vim" })
end)

if string.find(vim.fn.system("hostname"), "facebook") then
  vim.cmd([[set rtp+=/usr/local/share/myc/vim]])
  map("n", "<leader>j", ":MYC<CR>")
end

vim.opt.completeopt = { "menuone", "noinsert", "noselect" }
vim.opt.cursorline = true
vim.opt.hidden = true
vim.opt.hlsearch = true
vim.opt.mouse = "a"
vim.opt.number = true
vim.g.noswapfile = true
vim.opt.signcolumn = "number"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.termguicolors = true
vim.cmd([[colorscheme tokyonight]])

map("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- tmux navigator
map("", "<C-g>", "<Nop>")
map("n", "<C-g>h", ":lua require('nvim-tmux-navigation').NvimTmuxNavigateLeft()<CR>")
map("n", "<C-g>j", ":lua require('nvim-tmux-navigation').NvimTmuxNavigateDown()<CR>")
map("n", "<C-g>k", ":lua require('nvim-tmux-navigation').NvimTmuxNavigateUp()<CR>")
map("n", "<C-g>l", ":lua require('nvim-tmux-navigation').NvimTmuxNavigateRight()<CR>")
map("n", "<C-g>\\", ":lua require('nvim-tmux-navigation').NvimTmuxNavigateLastActive()<CR>")

-- clear highlighting
map("v", "<C-h>", ":nohlsearch<CR>")
map("n", "<C-h>", ":nohlsearch<CR>")

-- ergonomic save
map("n", "<leader>s", ":w<CR>")
-- save no autocmds (e.g. to prevent format on save
map("n", "<leader>w", ":noa w<CR>")

-- cd vim working directory to that of the current file
map("n", "<leader>cd", ":cd %:p:h<CR>")

-- " Copy text to the system clipboard from anywhere using the ANSI OCS52 sequence
map("v", "<leader>c", ":OSCYank<CR>")

-- replace up to next _ or -
map("n", "<leader>m", "ct_")
map("n", "<leader>n", "ct-")

-- delete buffer
map("n", "<C-c>", ":Bdelete<CR>")

-- init.lua
map("n", "<leader>..", ":e ~/.config/nvim/init.lua<CR>")
map("n", "<leader>.,", ":luafile %<CR>")
map("n", "<leader>.m", ":PackerSync<CR>")

-- toggle between buffer
map("n", "<leader><space>", "<C-^>")

-- refresh buffer
map("n", "<leader>e", ":e!<CR>")

-- Open new file adjacent to current file
map("n", "<leader>E", ':e <C-R>=expand("%:p:h") . "/" <CR>')

-- man word under cursor
map("n", "<leader>M", ":Man <C-R><C-W><CR>")

-- Dirvish
map("n", "<leader>d", ":Dirvish %<CR>")

-- fzf
map("n", "<leader>f", ":FzfLua files<CR>")
-- map("n", "<leader>F", ":FzfLua builtin<CR>")
map("n", "<leader>l", ":FzfLua buffers<CR>")
map("n", "<leader>L", ":FzfLua oldfiles<CR>")
map("n", "<leader>/", ":FzfLua live_grep_native<CR>")
map("n", "<leader>?", ":FzfLua grep_cword<CR>")
map("n", "<leader>x", ":FzfLua commands<CR>")
map("n", "<leader>S", ":FzfLua blines<CR>")

map("n", "<leader>F", ":lua require('stylua-nvim').format_file()<CR>")

-- lsp keybindings
map("n", "E", ":lua vim.diagnostic.goto_prev()<CR>")
map("n", "W", ":lua vim.diagnostic.goto_next()<CR>")
map("n", "gd", ":Telescope lsp_definitions<CR>")
map("n", "gr", ":Telescope lsp_references<CR>")
map("n", "gR", ":lua vim.lsp.buf.rename()<CR>")
map("n", "ga", ":Telescope lsp_code_actions<CR>")
map("n", "K", ":lua vim.lsp.buf.hover()<CR>")

require("Comment").setup()
require("nvim-autopairs").setup()

require("nvim-treesitter.configs").setup({
  ensure_installed = "maintained",
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
})

local lsp_status = require("lsp-status")
local lsp_config = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
lsp_status.register_progress()

lsp_config.rust_analyzer.setup({
  on_attach = function()
    lsp_status.on_attach()
    vim.api.nvim_command([[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]])
  end,
  capabilities = capabilities,
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        loadOutDirsFromCheck = true,
      },
      procMacro = {
        enable = false,
      },
    },
  },
})

local luadev = require("lua-dev").setup()
lsp_config.sumneko_lua.setup(luadev)

local function lspstatus()
  if #vim.lsp.buf_get_clients() > 0 then
    return lsp_status.status()
  else
    return ""
  end
end

require("lualine").setup({
  options = { theme = "tokyonight" },
  sections = { lualine_c = { "filename", lspstatus } },
})

local nvim_cmp = require("cmp")

nvim_cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ["<C-b>"] = nvim_cmp.mapping(nvim_cmp.mapping.scroll_docs(-4), { "i", "c" }),
    ["<C-f>"] = nvim_cmp.mapping(nvim_cmp.mapping.scroll_docs(4), { "i", "c" }),
    ["<C-Space>"] = nvim_cmp.mapping(nvim_cmp.mapping.complete(), { "i", "c" }),
    ["<C-y>"] = nvim_cmp.config.disable,
    ["<C-e>"] = nvim_cmp.mapping({
      i = nvim_cmp.mapping.abort(),
      c = nvim_cmp.mapping.close(),
    }),
    ["<CR>"] = nvim_cmp.mapping.confirm({ select = true }),
  },
  sources = nvim_cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "vsnip" },
  }, {
    { name = "buffer" },
  }),
})

vim.api.nvim_command("autocmd BufEnter,BufWinEnter,TabEnter *.rs :lua require'lsp_extensions'.inlay_hints{}")
vim.api.nvim_command("autocmd BufWritePre *.{c,cpp,h} :ClangFormat")
vim.api.nvim_command("autocmd BufWritePre *.lua :lua require('stylua-nvim').format_file()")

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost init.lua source <afile> | PackerCompile
  augroup end
]])
