vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },
  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "autocmds"

-- MOVE transparency to after mappings and schedule it
vim.schedule(function()
  require "mappings"

  -- Also apply transparency immediately on startup
  vim.defer_fn(function()
    -- transparent background
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
    vim.api.nvim_set_hl(0, "Pmenu", { bg = "none" })
    vim.api.nvim_set_hl(0, "Terminal", { bg = "none" })
    vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
    vim.api.nvim_set_hl(0, "FoldColumn", { bg = "none" })
    vim.api.nvim_set_hl(0, "Folded", { bg = "none" })
    vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
    vim.api.nvim_set_hl(0, "WhichKeyFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "none" })
    vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })
    vim.api.nvim_set_hl(0, "TelescopePromptBorder", { bg = "none" })
    vim.api.nvim_set_hl(0, "TelescopePromptTitle", { bg = "none" })
    -- transparent background for neotree
    vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "none" })
    vim.api.nvim_set_hl(0, "NeoTreeVertSplit", { bg = "none" })
    vim.api.nvim_set_hl(0, "NeoTreeWinSeparator", { bg = "none" })
    vim.api.nvim_set_hl(0, "NeoTreeEndOfBuffer", { bg = "none" })
    -- transparent background for nvim-tree
    vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NvimTreeVertSplit", { bg = "none" })
    vim.api.nvim_set_hl(0, "NvimTreeEndOfBuffer", { bg = "none" })
    -- transparent notify background
    vim.api.nvim_set_hl(0, "NotifyINFOBody", { bg = "none" })
    vim.api.nvim_set_hl(0, "NotifyERRORBody", { bg = "none" })
    vim.api.nvim_set_hl(0, "NotifyWARNBody", { bg = "none" })
    vim.api.nvim_set_hl(0, "NotifyTRACEBody", { bg = "none" })
    vim.api.nvim_set_hl(0, "NotifyDEBUGBody", { bg = "none" })
    vim.api.nvim_set_hl(0, "NotifyINFOTitle", { bg = "none" })
    vim.api.nvim_set_hl(0, "NotifyERRORTitle", { bg = "none" })
    vim.api.nvim_set_hl(0, "NotifyWARNTitle", { bg = "none" })
    vim.api.nvim_set_hl(0, "NotifyTRACETitle", { bg = "none" })
    vim.api.nvim_set_hl(0, "NotifyDEBUGTitle", { bg = "none" })
    vim.api.nvim_set_hl(0, "NotifyINFOBorder", { bg = "none" })
    vim.api.nvim_set_hl(0, "NotifyERRORBorder", { bg = "none" })
    vim.api.nvim_set_hl(0, "NotifyWARNBorder", { bg = "none" })
    vim.api.nvim_set_hl(0, "NotifyTRACEBorder", { bg = "none" })
    vim.api.nvim_set_hl(0, "NotifyDEBUGBorder", { bg = "none" })
  end, 100) -- 100ms delay to ensure everything is loaded
end)
