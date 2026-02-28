return {
  {
    "supermaven-inc/supermaven-nvim",
    event = "BufReadPost",
    lazy = true,
    opts = {
      disable_inline_completion = false,
      disable_keymaps = false,       -- disable default <Tab>
      keymaps = {
        accept_suggestion = "<C-f>", -- Ctrl + f (very reliable)
        clear_suggestion = "<C-]>",
      },
      ignore_filetypes = { cpp = true },
      log_level = "info",
    },
  },
}
