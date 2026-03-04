return {
  {
    "3rd/image.nvim",
    build = false,
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
          only_render_image_at_cursor_mode = "popup", -- or "inline"
          floating_windows = false,                   -- if true, images will be rendered in floating markdown windows
          filetypes = { "markdown", "vimwiki" },      -- markdown extensions (ie. quarto) can go here
        },
      },

      window_overlap_clear_enabled = true,
    },
    hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" }, -- render image files as images when opened
  },

  {
    "3rd/diagram.nvim",
    ft = { "markdown", "norg" }, -- ✅ load only for these
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
