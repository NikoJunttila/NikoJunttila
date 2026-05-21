-- Editor theme is driven entirely by Omarchy. We read
-- ~/.config/omarchy/current/theme/neovim.lua, which is a LazyVim-style spec:
--   { "tahayvr/matteblack.nvim", lazy = false, priority = 1000 },
--   { "LazyVim/LazyVim", opts = { colorscheme = "matteblack" } },
-- We install the colorscheme plugin via lazy.nvim and stash the colorscheme
-- name in vim.g.omarchy_colorscheme; init.lua applies it after lazy.setup.
--
-- If Omarchy is not installed on this machine, fall back to a built-in
-- colorscheme so the config still works.

local FALLBACK_COLORSCHEME = "habamax"
local omarchy_file = vim.fn.expand "~/.config/omarchy/current/theme/neovim.lua"
local specs = {}

if vim.uv.fs_stat(omarchy_file) then
  local ok, raw = pcall(dofile, omarchy_file)
  if ok and type(raw) == "table" then
    for _, entry in ipairs(raw) do
      if type(entry) == "table" and type(entry[1]) == "string" then
        if entry[1] == "LazyVim/LazyVim" then
          if entry.opts and entry.opts.colorscheme then
            vim.g.omarchy_colorscheme = entry.opts.colorscheme
          end
        else
          table.insert(specs, entry)
        end
      end
    end
  end
end

if not vim.g.omarchy_colorscheme then
  vim.g.omarchy_colorscheme = FALLBACK_COLORSCHEME
end

return specs
