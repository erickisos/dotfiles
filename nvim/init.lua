vim.loader.enable()

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true

-- Display
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
vim.opt.wrap = false
vim.opt.termguicolors = true

-- Editing
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true

-- Misc
vim.opt.mouse = "a"
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.clipboard = "unnamedplus"

-- Plugin bootstrap (lazy.nvim — auto-clones on first launch)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- Fuzzy finder
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        },
        config = function()
            local telescope = require("telescope")
            telescope.setup({
                defaults = {
                    path_display = { "truncate" },
                },
            })
            telescope.load_extension("fzf")
            telescope.load_extension("projects")
        end,
    },
    -- Project switcher (auto-detects roots via git, package.json, etc.)
    {
        "ahmedkhalf/project.nvim",
        config = function()
            require("project_nvim").setup({
                detection_methods = { "lsp", "pattern" },
                patterns = { ".git", "package.json", "Cargo.toml", "pyproject.toml", "build.gradle" },
            })
        end,
    },
    { "williamboman/mason.nvim", opts = {} },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim" },
        opts = {
            ensure_installed = { "lua_ls", "ts_ls", "pyright", "rust_analyzer", "jdtls" },
            automatic_installation = true,
        },
    },
    { "mfussenegger/nvim-jdtls", ft = "java" },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        opts = {
            ensure_installed = { "lua", "typescript", "tsx", "python", "rust", "java" },
            highlight = { enable = true },
            indent = { enable = true },
        },
    },
})

-- LSP (built-in — jdtls excluded, handled by nvim-jdtls via ftplugin/java.lua)
vim.lsp.enable({ "lua_ls", "ts_ls", "pyright", "rust_analyzer" })

-- Keymaps
local map = vim.keymap.set

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        local opts = { buffer = ev.buf }
        map("n", "gd",         vim.lsp.buf.definition,      vim.tbl_extend("force", opts, { desc = "Go to definition" }))
        map("n", "gD",         vim.lsp.buf.declaration,     vim.tbl_extend("force", opts, { desc = "Go to declaration" }))
        map("n", "gr",         vim.lsp.buf.references,      vim.tbl_extend("force", opts, { desc = "References" }))
        map("n", "gi",         vim.lsp.buf.implementation,  vim.tbl_extend("force", opts, { desc = "Go to implementation" }))
        map("n", "K",          vim.lsp.buf.hover,           vim.tbl_extend("force", opts, { desc = "Hover docs" }))
        map("n", "<leader>cr", vim.lsp.buf.rename,          vim.tbl_extend("force", opts, { desc = "Rename symbol" }))
        map("n", "<leader>ca", vim.lsp.buf.code_action,     vim.tbl_extend("force", opts, { desc = "Code action" }))
        map("n", "<leader>cf", vim.lsp.buf.format,          vim.tbl_extend("force", opts, { desc = "Format buffer" }))
        map("n", "[d",         vim.diagnostic.goto_prev,    vim.tbl_extend("force", opts, { desc = "Prev diagnostic" }))
        map("n", "]d",         vim.diagnostic.goto_next,    vim.tbl_extend("force", opts, { desc = "Next diagnostic" }))
        map("n", "<leader>e",  vim.diagnostic.open_float,   vim.tbl_extend("force", opts, { desc = "Show diagnostic" }))
    end,
})

-- Telescope
map("n", "<leader>ff", function() require("telescope.builtin").find_files() end,  { desc = "Find files" })
map("n", "<leader>fg", function() require("telescope.builtin").live_grep() end,   { desc = "Live grep" })
map("n", "<leader>fb", function() require("telescope.builtin").buffers() end,     { desc = "Buffers" })
map("n", "<leader>fh", function() require("telescope.builtin").help_tags() end,   { desc = "Help tags" })
map("n", "<leader>fp", "<cmd>Telescope projects<cr>",                             { desc = "Projects" })

-- Window navigation
map("n", "<leader>wv",    "<C-w>v",     { desc = "Split vertical" })
map("n", "<leader>ws",    "<C-w>s",     { desc = "Split horizontal" })
map("n", "<leader>wc",    ":close<CR>", { desc = "Close window" })
map("n", "<leader>w<C-o>","<C-w>o",     { desc = "Close other windows" })
map("n", "<leader>wh",    "<C-w>h",     { desc = "Go left" })
map("n", "<leader>wl",    "<C-w>l",     { desc = "Go right" })
map("n", "<leader>wj",    "<C-w>j",     { desc = "Go down" })
map("n", "<leader>wk",    "<C-w>k",     { desc = "Go up" })

-- Open menu
map("n", "<leader>ot", ":terminal<CR>", { desc = "Open terminal" })
