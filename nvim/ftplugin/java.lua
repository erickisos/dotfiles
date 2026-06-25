local jdtls = require("jdtls")
local mason_packages = vim.fn.stdpath("data") .. "/mason/packages/jdtls"

-- Per-project workspace so jdtls state doesn't bleed across projects
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. project_name

local config = {
    cmd = {
        "java",
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.level=ALL",
        "-Xmx1g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens", "java.base/java.util=ALL-UNNAMED",
        "--add-opens", "java.base/java.lang=ALL-UNNAMED",
        "-jar", vim.fn.glob(mason_packages .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
        "-configuration", mason_packages .. "/config_mac",
        "-data", workspace,
    },
    root_dir = jdtls.setup.find_root({ ".git", "gradlew", "mvnw", "pom.xml", "build.gradle", "build.gradle.kts" }),
    settings = {
        java = {
            eclipse = { downloadSources = true },
            maven = { downloadSources = true },
            configuration = { updateBuildConfiguration = "interactive" },
            implementationsCodeLens = { enabled = true },
            referencesCodeLens = { enabled = true },
            format = { enabled = true },
        },
    },
}

jdtls.start_or_attach(config)
