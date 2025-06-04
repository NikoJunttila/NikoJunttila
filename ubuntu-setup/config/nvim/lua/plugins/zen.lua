return {
  {
    "folke/zen-mode.nvim",
    lazy = false, -- this makes it load on startup
    config = function()
      require("zen-mode").setup {}
      vim.keymap.set("n", "<leader>zm", function()
        require("zen-mode").toggle()
      end, { desc = "Toggle Zen Mode" })
    end,
  },
}

