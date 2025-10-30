return {
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {
        keymaps = {
          -- Normal mode
          -- insert = "ys", -- ys + motion + char: "ys" + "iw" + "'" = 'word'
          -- insert_line = "yss", -- yss + char: surrounds entire line
          -- normal = "ds", -- ds + char: delete surround
          -- normal_cur = "cs", -- cs + old + new: change surround
          -- normal_line = "yS", -- yS + motion + char: surround on new lines
          -- normal_cur_line = "cS", -- cS + old + new: change surround on new lines

          -- Visual mode
          visual = "S", -- Select text, press S, then the char
          visual_line = "gS", -- Select lines, press gS, then the char

          -- Delete mode
          delete = "ds", -- ds + char: delete surrounding
        },
      }
    end,
  },
}
-- Quick reference for default usage:
--
-- ysiw" - surround inner word with "quotes"
-- yss) - surround entire line with (parentheses)
-- ds" - delete surrounding "quotes"
-- cs"' - change surrounding "quotes" to 'single quotes'
-- S" in visual mode - surround selection with "quotes
