vim.g.mapleader = " "

-- Theming is driven entirely by Omarchy. NvChad's internal modules still
-- reach for base46 in two ways; stub both so the rest of NvChad keeps working
-- without the base46 plugin or its generated cache:
--   1. dofile(vim.g.base46_cache .. "<group>") — used by nvchad.configs.*
--      and nvchad.tabufline.* to load themed highlight groups.
--   2. require("base46")                         — used by nvchad.utils at
--      module load time (pulled in by NvCheatsheet, theme picker, etc.).
-- The active colorscheme provides the actual highlights instead.
vim.g.base46_cache = vim.fn.stdpath "data" .. "/omarchy-base46-stub/"
do
  local stub = vim.g.base46_cache
  local orig_dofile = _G.dofile
  -- volt/highlights.lua dofiles "colors" and indexes the result, so hand back
  -- a table whose every field resolves to a usable hex value.
  local stub_colors = setmetatable({}, {
    __index = function()
      return "#808080"
    end,
  })
  _G.dofile = function(path)
    if type(path) == "string" and path:sub(1, #stub) == stub then
      if path:sub(#stub + 1) == "colors" then
        return stub_colors
      end
      return
    end
    return orig_dofile(path)
  end
end

package.preload["base46"] = function()
  local noop = function() end
  return setmetatable({}, {
    __index = function()
      return noop
    end,
  })
end

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
  },
  { import = "plugins" },
}, lazy_config)

require "options"
require "autocmds"

-- Apply theme from Omarchy (or fallback). See lua/plugins/omarchy.lua.
pcall(vim.cmd.colorscheme, vim.g.omarchy_colorscheme)

require "mappings"
