-- Plugins {{{

local function install_plugins(plugins)
    local pack_path = vim.fn.stdpath("data") .. "/site/pack/plugins/start/"

    for _, repo in ipairs(plugins) do
        local name = repo:match(".*/(.*)")
        local plugin_path = pack_path .. name
        if vim.fn.isdirectory(plugin_path) == 0 then
            print("Installing " .. name .. "...")
            vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/" .. repo, plugin_path })
        end
    end
end

-- List plugin GitHub repositories here
install_plugins({
    "zenbones-theme/zenbones.nvim",
    "rktjmp/lush.nvim", -- dependency for zenbones.nvim
    "nvim-treesitter/nvim-treesitter",
    "nvim-lualine/lualine.nvim",
    "nvim-tree/nvim-web-devicons",
    "lewis6991/gitsigns.nvim",
    "lukas-reineke/indent-blankline.nvim",
    "mason-org/mason.nvim",
    "mason-org/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
})

-- Setup plugins
require("lualine").setup()
require("gitsigns").setup()
require("ibl").setup()
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "gopls", "jsonls", "lua_ls", "pyright", "clangd" },
})

require("nvim-treesitter").setup({
    ensure_installed = {
        "lua", "vim", "vimdoc",
        "go", "json", "yaml",
        "bash", "markdown", "markdown_inline",
        "c", "python",
    },
    auto_install = true,
    highlight = { enable = true },
    indent = { enable = true },
})

-- Enable LSP servers (Neovim 0.11+)
vim.lsp.enable('golangci_lint_ls')
vim.lsp.enable('gopls')
vim.lsp.enable('jsonls')
vim.lsp.enable('lua_ls')
vim.lsp.enable('pyright')
vim.lsp.enable('clangd')

-- }}}

-- Options {{{

-- Leader Settings
vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

-- Theme
local theme = "zenwritten"
vim.opt.background = "dark"
vim.cmd.colorscheme(theme)
vim.opt.guicursor = ""

-- Remove the background
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

-- Options

vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.viminfo = ""
vim.opt.swapfile = false
vim.opt.wrap = false
vim.opt.spelllang = "en_us"
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.breakindent = true
vim.opt.nrformats:append({ "alpha", "octal", "hex", "bin", "blank" })
vim.opt.showmode = true
vim.opt.showcmd = true
vim.opt.showmatch = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.autoread = true
vim.opt.backspace = { "indent", "eol", "start" }
vim.opt.termguicolors = true
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.ruler = true
vim.opt.smoothscroll = true
vim.opt.hidden = true
vim.opt.wildmenu = true
vim.opt.wildmode = "list:longest"
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 10
vim.opt.mouse = ""
vim.opt.errorbells = false
vim.opt.visualbell = false
vim.opt.path:append("**")
vim.opt.modeline = true
vim.opt.modelines = 5
vim.opt.numberwidth = 4
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 50
vim.opt.viewoptions:remove("options")


-- Use Neovim's dedicated data directory to avoid conflicts with standard Vim
local undo_dir = vim.fn.stdpath("data") .. "/undo"

if vim.fn.isdirectory(undo_dir) == 0 then
    vim.fn.mkdir(undo_dir, "p", 448)
end
vim.opt.undodir = undo_dir
vim.opt.undofile = true

-- Keymaps
local map = vim.keymap.set

-- Escape shortcuts (Insert, Visual, Command)
local jk_modes = { "i", "v", "c" }
map(jk_modes, "jk", "<esc>")
map(jk_modes, "Jk", "<esc>")
map(jk_modes, "JK", "<esc>")
map(jk_modes, "jK", "<esc>")

-- Disable arrow keys
local no_arrows = { "n", "i", "v" }
map(no_arrows, "<Up>", "<Nop>")
map(no_arrows, "<Down>", "<Nop>")
map(no_arrows, "<Left>", "<Nop>")
map(no_arrows, "<Right>", "<Nop>")

-- Utilities
map("n", "<leader>d", ":r!date<CR>")
map("n", "<leader>i", "gg=G``")

-- Folds
vim.opt.foldenable = true
vim.opt.foldmethod = "marker"
vim.opt.foldmarker = { "{{{", "}}}" }
vim.opt.foldlevel = 0
vim.opt.foldlevelstart = 0
vim.opt.foldminlines = 1
vim.opt.foldcolumn = "2"

-- Autocmds
local group = vim.api.nvim_create_augroup("UserConfig", { clear = true })

-- Persist folds and cursor
vim.api.nvim_create_autocmd("BufWinLeave", {
    group = group,
    pattern = "*.*",
    command = "mkview",
})

vim.api.nvim_create_autocmd("BufWinEnter", {
    group = group,
    pattern = "*.*",
    command = "silent! loadview",
})

-- Remove trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
    group = group,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

-- Fix: Ensure foldmethod stays 'marker' even if plugins try to change it
-- vim.api.nvim_create_autocmd({ "FileType", "BufEnter" }, {
--     callback = function()
--         vim.opt_local.foldmethod = "marker"
--     end,
-- })

-- }}}

