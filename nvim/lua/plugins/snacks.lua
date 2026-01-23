return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      styles = {
        notification = {
          wo = { wrap = true } -- Wrap notifications
        }
      },
      -- Enable image viewing
      image = {
        enabled = true,
        -- Backend to use (kitty, iterm, wezterm, or tmux)
        backend = "kitty", -- automatically detect
      },
      scroll = {
        enabled = false,
        animate = {
          duration = { step = 15, total = 250 },
          easing = "linear",
        },
      },
    },
    keys = {
      -- Image viewing
      { "<leader>ip", function() Snacks.image.preview() end,           desc = "Preview Image" },
      { "<leader>ic", function() Snacks.image.close() end,             desc = "Close Image" },

      -- Toggle features
      { "<leader>.",  function() Snacks.scratch() end,                 desc = "Toggle Scratch Buffer" },
      { "<leader>S",  function() Snacks.scratch.select() end,          desc = "Select Scratch Buffer" },
      { "<leader>nh", function() Snacks.notifier.show_history() end,   desc = "Notification History" },
      { "<leader>un", function() Snacks.notifier.hide() end,           desc = "Dismiss All Notifications" },

      -- Git integration
      { "<leader>gb", function() Snacks.git.blame_line() end,          desc = "Git Blame Line" },
      { "<leader>gB", function() Snacks.gitbrowse() end,               desc = "Git Browse" },

      -- Word highlighting
      { "]]",         function() Snacks.words.jump(vim.v.count1) end,  desc = "Next Reference" },
      { "[[",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference" },
    },
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          -- Setup some globals for easier access
          _G.dd = function(...)
            Snacks.debug.inspect(...)
          end
          _G.bt = function()
            Snacks.debug.backtrace()
          end
          vim.print = _G.dd -- Override print to use snacks.debug.inspect
        end,
      })
    end,
  }
}
