local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettier" },
    html = { "prettier" },
    go = { "gofumpt", "goimports" }, -- or just { "gofmt" } for simpler formatting
    templ = { "templ" },
    -- odin = { "odinfmt" },
    -- c = { "clang-format" },
    -- cpp = { "clang-format" },  -- might as well add C++ too
  },
  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
}
return options
