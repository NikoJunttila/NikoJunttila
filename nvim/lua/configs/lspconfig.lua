require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "gopls", "ols", "clangd", "ts_ls", "svelte","templ" }
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers 
