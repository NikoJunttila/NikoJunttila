return {
  {
    "3rd/image.nvim",
    build = false,
    opts = {
      backend = "kitty",
      processor = "magick_cli",
      integrations = {
        markdown = {
          enabled = true,
          clear_in_insert_mode = false,
          only_render_image_at_cursor = false,
        },
      },
      hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" },
    },
  },

  -- {
  --   "3rd/diagram.nvim",
  --   dependencies = { "3rd/image.nvim" },
  --   opts = {
  --     -- Manual-only workflow: no automatic rendering
  --     events = {
  --       render_buffer = {}, -- disable auto render
  --       clear_buffer = { "BufUnload" }, -- safer than BufLeave
  --     },
  --     renderer_options = {
  --       mermaid = {
  --         theme = "dark",
  --         scale = 2,
  --         cli_args = nil,
  --       },
  --     },
  --   },
  --   keys = {
  --     {
  --       "<leader>k",
  --       function()
  --         local ft = vim.bo.filetype
  --         if ft ~= "markdown" and ft ~= "norg" then
  --           return
  --         end
  --         require("diagram").show_diagram_hover()
  --       end,
  --       mode = "n",
  --       desc = "Show diagram hover",
  --     },
  --   },
  -- },
}
