return {
  {
    "3rd/image.nvim",
    build = false,

    -- load for markdown/neorg usage
    ft = { "markdown", "vimwiki", "norg" },

    -- and also load early when opening an image file directly
    event = {
      { event = "BufReadPre", pattern = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" } },
      { event = "BufNewFile", pattern = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" } },
    },

    opts = {
      backend = "kitty",
      processor = "magick_cli",

      max_width = 100,
      max_height = 40,

      integrations = {
        markdown = {
          enabled = true,
          clear_in_insert_mode = false,
          download_remote_images = true,
          only_render_image_at_cursor = false,
          only_render_image_at_cursor_mode = "popup",
          floating_windows = false,
          filetypes = { "markdown", "vimwiki" },
        },
        neorg = {
          enabled = true,
          filetypes = { "norg" },
        },
      },

      window_overlap_clear_enabled = true,

      -- this still needs to be here
      hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" },
    },
  },

  {
    "3rd/diagram.nvim",
    ft = { "markdown", "norg" },
    dependencies = { "3rd/image.nvim" },
    opts = {
      events = {
        render_buffer = { "InsertLeave", "BufWinEnter", "TextChanged" },
        clear_buffer = { "BufLeave" },
      },
      renderer_options = {
        mermaid = {
          theme = "dark",
          scale = 2,
          cli_args = nil,
        },
      },
    },
  },
}
