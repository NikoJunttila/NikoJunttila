return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      lsp = {
        signature = { enabled = false }, -- disable signature help popups
        hover = { enabled = false },     -- optional: disable hover doc popups too
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      {
        "rcarriga/nvim-notify",
        opts = {
          background_colour = "#000000",
        },
      },
    },
  },
  {
    "folke/which-key.nvim",
    keys = { "<leader>", "<c-w>", '"', "'", "`", "c", "v", "g" },
    cmd = "WhichKey",
    opts = function()
      dofile(vim.g.base46_cache .. "whichkey")
      return {}
    end,
  },
  {
    "folke/zen-mode.nvim",
    keys = {
      { "<leader>zm", function() require("zen-mode").toggle() end, desc = "Toggle Zen Mode" },
    },
    opts = {
      window = {
        backdrop = 1, -- 1 means fully opaque (no transparency blending)
        width = 120,  -- width of the Zen window
        options = {
          -- You can disable native vim UI elements here:
          -- number = false,
          -- relativenumber = false,
          -- signcolumn = "no",
        }
      },
      -- You can use this callback to force pitch black background sidebars:
      on_open = function()
        vim.api.nvim_set_hl(0, "ZenBg", { bg = "#000000" })
      end,
    },
  },
  {
    "folke/trouble.nvim",
    opts = {},
    cmd = "Trouble",
    keys = {
      {
        "<leader>er",
        "<cmd>Trouble diagnostics toggle focus=true filter.severity=vim.diagnostic.severity.ERROR<cr>",
        desc = "Errors (Trouble)",
      },
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
    },
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    -- lazy = false,
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
      },
    },
    keys = {
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
