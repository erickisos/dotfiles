return {
    settings = {
        ["rust-analyzer"] = {
            checkOnSave = { command = "clippy" },
            cargo = { allFeatures = true },
            inlayHints = {
                bindingModeHints = { enable = true },
                chainingHints = { enable = true },
                parameterHints = { enable = true },
                typeHints = { enable = true },
            },
        },
    },
}
