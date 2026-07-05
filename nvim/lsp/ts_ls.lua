return {
    -- Tiered: prefer the repo/workspace root over the nearest package.json,
    -- so multi-module npm projects don't hoist the LSP root to a submodule.
    -- vim.fs.root() checks each entry across all ancestor dirs before
    -- falling back to the next entry (see :h vim.fs.root).
    root_markers = {
        { ".git", "pnpm-workspace.yaml", "lerna.json", "nx.json", "turbo.json" },
        { "package.json", "jsconfig.json", "tsconfig.json" },
    },
    init_options = {
        preferences = {
            includeInlayParameterNameHints = "all",
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
        },
    },
}
