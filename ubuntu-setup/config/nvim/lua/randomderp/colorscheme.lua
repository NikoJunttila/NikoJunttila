-- Configure catppuccin
require("catppuccin").setup({
  flavour = "mocha", -- latte, frappe, macchiato, mocha
  background = {
    light = "latte",
    dark = "mocha",
  },
  transparent_background = false,
  styles = {
    comments = { "italic" },
    conditionals = { "italic" },
  },
  integrations = {
    telescope = true,
    treesitter = true,
    cmp = true,
    gitsigns = true,
  },
})

-- Set the colorscheme
vim.cmd.colorscheme("catppuccin")
