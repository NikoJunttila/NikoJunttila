return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {
      lsp = {
        -- blink.cmp already provides signature help; vim.lsp.buf.hover() handles hover.
        signature = { enabled = false },
        hover = { enabled = false },
      },
      -- Snacks.notifier owns vim.notify; let noice stay out of the way.
      notify = { enabled = false },
      messages = { enabled = false },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
      },
      -- command_palette preset pins cmdline_popup near the top (row = 3);
      -- recenter both the input box and the completion popup.
      views = {
        cmdline_popup = {
          position = { row = "50%", col = "50%" },
        },
        cmdline_popupmenu = {
          position = { row = "60%", col = "50%" },
        },
      },
    },
  },
  {
    "folke/which-key.nvim",
    keys = { "<leader>", "<c-w>", '"', "'", "`", "c", "v", "g" },
    cmd = "WhichKey",
    opts = {},
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
    lazy = false,
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      notifier = { enabled = true, timeout = 3000 },
      quickfile = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      picker = { enabled = true },
      explorer = { enabled = true },
      terminal = {},
      zen = { enabled = true },
      input = { enabled = true },
      scroll = { enabled = false },
      image = { enabled = false, backend = "kitty" },
      styles = {
        notification = {
          wo = { wrap = true },
        },
      },
    },
    keys = {
      {
        "<leader>.",
        function()
          Snacks.scratch()
        end,
        desc = "Toggle Scratch Buffer",
      },
      {
        "<leader>S",
        function()
          Snacks.scratch.select()
        end,
        desc = "Select Scratch Buffer",
      },
      {
        "<leader>nh",
        function()
          Snacks.notifier.show_history()
        end,
        desc = "Notification History",
      },
      {
        "<leader>un",
        function()
          Snacks.notifier.hide()
        end,
        desc = "Dismiss All Notifications",
      },
      {
        "<leader>zm",
        function()
          Snacks.zen()
        end,
        desc = "Toggle Zen Mode",
      },
      {
        "<leader>gb",
        function()
          Snacks.git.blame_line()
        end,
        desc = "Git Blame Line",
      },
      {
        "<leader>gB",
        function()
          Snacks.gitbrowse()
        end,
        desc = "Git Browse",
      },
      {
        "]]",
        function()
          Snacks.words.jump(vim.v.count1)
        end,
        desc = "Next Reference",
      },
      {
        "[[",
        function()
          Snacks.words.jump(-vim.v.count1)
        end,
        desc = "Prev Reference",
      },
    },
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          _G.dd = function(...)
            Snacks.debug.inspect(...)
          end
          _G.bt = function()
            Snacks.debug.backtrace()
          end
          vim.print = _G.dd
        end,
      })
    end,
  },
}
