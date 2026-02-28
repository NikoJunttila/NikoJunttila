-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :( 

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "catppuccin",

	hl_override = {
		Normal = { bg = "none" },
		NormalFloat = { bg = "none" },
		FloatBorder = { bg = "none" },
		Pmenu = { bg = "none" },
		Terminal = { bg = "none" },
		EndOfBuffer = { bg = "none" },
		FoldColumn = { bg = "none" },
		Folded = { bg = "none" },
		SignColumn = { bg = "none" },
		NormalNC = { bg = "none" },
		WhichKeyFloat = { bg = "none" },
		-- TelescopeBorder = { bg = "none" },
		-- TelescopeNormal = { bg = "none" },
		-- TelescopePromptBorder = { bg = "none" },
		-- TelescopePromptTitle = { bg = "none" },
		NeoTreeNormal = { bg = "none" },
		NeoTreeNormalNC = { bg = "none" },
		NeoTreeVertSplit = { bg = "none" },
		NeoTreeWinSeparator = { bg = "none" },
		NeoTreeEndOfBuffer = { bg = "none" },
		NvimTreeNormal = { bg = "none" },
		NvimTreeVertSplit = { bg = "none" },
		NvimTreeEndOfBuffer = { bg = "none" },
		NotifyINFOBody = { bg = "none" },
		NotifyERRORBody = { bg = "none" },
		NotifyWARNBody = { bg = "none" },
		NotifyTRACEBody = { bg = "none" },
		NotifyDEBUGBody = { bg = "none" },
		NotifyINFOTitle = { bg = "none" },
		NotifyERRORTitle = { bg = "none" },
		NotifyWARNTitle = { bg = "none" },
		NotifyTRACETitle = { bg = "none" },
		NotifyDEBUGTitle = { bg = "none" },
		NotifyINFOBorder = { bg = "none" },
		NotifyERRORBorder = { bg = "none" },
		NotifyWARNBorder = { bg = "none" },
		NotifyTRACEBorder = { bg = "none" },
		NotifyDEBUGBorder = { bg = "none" },
		IblIndent = { fg = "#2a2b3d", bg = "none" },
		IblScope = { fg = "#cba6f7", bg = "none", bold = true },
	},
}

-- M.nvdash = { load_on_startup = true }
-- M.ui = {
--       tabufline = {
--          lazyload = false
--      }
--}

return M
