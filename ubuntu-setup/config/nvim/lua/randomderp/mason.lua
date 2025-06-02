-- ~/.config/nvim/lua/config/mason.lua

-- Set up Mason
require("mason").setup()

-- Ensure the following language servers are installed
require("mason-lspconfig").setup({
  ensure_installed = {
    "gopls",      -- Go
    "lua_ls",     -- Lua
    "clangd",     -- C/C++
    "tsserver",   -- JavaScript / TypeScript
    "ols"  --odinlang
  },
  automatic_installation = true,
})

-- Setup LSP servers
local lspconfig = require("lspconfig")

require("mason-lspconfig").setup_handlers({
  -- Default handler for servers installed by mason-lspconfig
  function(server_name)
    lspconfig[server_name].setup({})
  end,

  -- Custom config for Lua LSP
  ["lua_ls"] = function()
    lspconfig.lua_ls.setup({
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false,
          },
        },
      },
    })
  end,
})
