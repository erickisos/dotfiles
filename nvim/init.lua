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
    -- Colorscheme
    {
        "tomasr/molokai",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("molokai")
        end,
    },
    -- Completion
    {
        "saghen/blink.cmp",
        version = "*",
        opts = {
            keymap = { preset = "default" },
            completion = { documentation = { auto_show = true } },
        },
    },
    -- Task runner (Gradle, npm, etc.)
    {
        "stevearc/overseer.nvim",
        opts = {},
    },
    -- Clojure REPL integration
    { "Olical/conjure", ft = { "clojure", "fennel" } },
    -- Auto-close brackets/quotes
    { "windwp/nvim-autopairs", opts = {} },
    -- Keybinding hints popup
    { "folke/which-key.nvim", opts = {} },
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
    -- Project switcher (auto-detects roots via git, monorepo markers, etc.)
    {
        "ahmedkhalf/project.nvim",
        config = function()
            require("project_nvim").setup({
                detection_methods = { "lsp", "pattern" },
                -- Only root-level markers here. project.nvim's pattern search stops at
                -- the FIRST ancestor directory where any pattern matches, so per-module
                -- markers like package.json/build.gradle "hoist" the root to whichever
                -- npm package or Gradle submodule the buffer happens to be in.
                patterns = {
                    ".git",
                    "pnpm-workspace.yaml",
                    "lerna.json",
                    "nx.json",
                    "turbo.json",
                    "settings.gradle",
                    "settings.gradle.kts",
                },
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
vim.lsp.config("*", { capabilities = require("blink.cmp").get_lsp_capabilities() })
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

-- Doom's SPC . : find files starting from the current buffer's directory
map("n", "<leader>.", function()
    require("telescope.builtin").find_files({ cwd = vim.fn.expand("%:p:h") })
end, { desc = "Find file (buffer dir)" })

-- Live-scan Documents/ and OpenSource/ for git project roots (not limited to
-- history project.nvim has already visited)
local function find_all_projects()
    local roots = { vim.fn.expand("~/Documents"), vim.fn.expand("~/OpenSource") }
    local seen, projects = {}, {}
    for _, root in ipairs(roots) do
        for _, path in ipairs(vim.fn.systemlist({ "find", root, "-maxdepth", "4", "-name", ".git" })) do
            local project = vim.fn.fnamemodify(path, ":h")
            if not seen[project] then
                seen[project] = true
                table.insert(projects, project)
            end
        end
    end
    table.sort(projects)
    return projects
end

local function pick_project_then_find_files()
    local pickers = require("telescope.pickers")
    local finders = require("telescope.finders")
    local conf = require("telescope.config").values
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")

    pickers.new({}, {
        prompt_title = "Find file in project",
        finder = finders.new_table({ results = find_all_projects() }),
        sorter = conf.generic_sorter({}),
        previewer = false,
        attach_mappings = function(prompt_bufnr)
            actions.select_default:replace(function()
                local selection = action_state.get_selected_entry()
                actions.close(prompt_bufnr)
                vim.cmd.tcd(selection[1])
                require("telescope.builtin").find_files({ cwd = selection[1] })
            end)
            return true
        end,
    }):find()
end

-- Doom-style project navigation: <leader>p f/F/p
map("n", "<leader>pf", function() require("telescope.builtin").find_files() end, { desc = "Find file (current project)" })
map("n", "<leader>pF", pick_project_then_find_files,                             { desc = "Find file (different project)" })
map("n", "<leader>pp", "<cmd>Telescope projects<cr>",                            { desc = "Switch project" })

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

-- Overseer (task runner)
map("n", "<leader>or", "<cmd>OverseerRun<cr>",     { desc = "Run task" })
map("n", "<leader>ol", "<cmd>OverseerToggle<cr>",  { desc = "Toggle task list" })
