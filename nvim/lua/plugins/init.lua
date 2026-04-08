return {
  -- formatting
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = require "configs.conform",
  },

  -- lsp config
  {
    "neovim/nvim-lspconfig",
    event = "User FilePost",
    config = function()
      require("configs.lspconfig").defaults()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    event = "User FilePost",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        "html",
        "cssls",
        "gopls",
        "ols",
        "clangd",
        "ts_ls", -- changed from tsserver
        "svelte",
        "templ",
      },
      automatic_installation = true,
    },
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    event = "User FilePost",
    opts = {
      ensure_installed = {
        -- Formatters
        "stylua",
        "prettier",
        "gofumpt",
        "goimports",
      },
      auto_update = false,
      run_on_start = true,
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup {
        install_dir = vim.fn.stdpath "data" .. "/site",
      }

      -- Auto-install parsers when entering a buffer
      local parsers = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "go",
        "odin",
        "c",
        "typescript",
        "javascript",
        "svelte",
        "templ",
        "markdown",
        "markdown_inline",
      }

      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          local buf = vim.api.nvim_get_current_buf()
          -- pcall to avoid errors if parser isn't available
          pcall(vim.treesitter.start, buf)
        end,
      })

      -- Install missing parsers on startup
      local installed = require("nvim-treesitter").get_installed()
      for _, lang in ipairs(parsers) do
        if not vim.tbl_contains(installed, lang) then
          vim.cmd("TSInstall " .. lang)
        end
      end
    end,
  },
}
