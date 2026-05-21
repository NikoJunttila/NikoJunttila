local autocmd = vim.api.nvim_create_autocmd

-- user event that loads after UIEnter + only if file buf is there
autocmd({ "UIEnter", "BufReadPost", "BufNewFile" }, {
  group = vim.api.nvim_create_augroup("NvFilePost", { clear = true }),
  callback = function(args)
    local file = vim.api.nvim_buf_get_name(args.buf)
    local buftype = vim.api.nvim_get_option_value("buftype", { buf = args.buf })

    if not vim.g.ui_entered and args.event == "UIEnter" then
      vim.g.ui_entered = true
    end

    if file ~= "" and buftype ~= "nofile" and vim.g.ui_entered then
      vim.api.nvim_exec_autocmds("User", { pattern = "FilePost", modeline = false })
      vim.api.nvim_del_augroup_by_name "NvFilePost"

      vim.schedule(function()
        vim.api.nvim_exec_autocmds("FileType", {})

        if vim.g.editorconfig then
          require("editorconfig").config(args.buf)
        end
      end)
    end
  end,
})

-- Re-apply transparency on every colorscheme change so it survives Omarchy
-- theme switches.
local transparent_groups = {
  "Normal",
  "NormalFloat",
  "FloatBorder",
  "Pmenu",
  "Terminal",
  "EndOfBuffer",
  "FoldColumn",
  "Folded",
  "SignColumn",
  "NormalNC",
  "WhichKeyFloat",
}

-- Style NvChad's statusline (St_*) groups from the active colorscheme. base46
-- used to populate these; with base46 stubbed out we derive them here so the
-- rounded separators render with proper background fills.
local function style_statusline()
  local function hl(name)
    local h = vim.api.nvim_get_hl(0, { name = name, link = false }) or {}
    return h
  end
  local function fg(name, fallback)
    return hl(name).fg or fallback
  end

  local stl_bg = hl("StatusLine").bg or hl("Normal").bg or "NONE"
  local stl_fg = hl("StatusLine").fg or hl("Normal").fg or "#cdd6f4"

  local mode_palette = {
    Normal = fg("Function", "#89b4fa"),
    Visual = fg("Statement", "#cba6f7"),
    Insert = fg("String", "#a6e3a1"),
    Terminal = fg("String", "#a6e3a1"),
    NTerminal = fg("Comment", "#7f849c"),
    Replace = fg("DiagnosticError", "#f38ba8"),
    Confirm = fg("WarningMsg", "#f9e2af"),
    Command = fg("Identifier", "#fab387"),
    Select = fg("Constant", "#94e2d5"),
  }

  for mode, color in pairs(mode_palette) do
    -- icon block: dark text on the mode color
    vim.api.nvim_set_hl(0, "St_" .. mode .. "Mode", { fg = stl_bg, bg = color, bold = true })
    -- separator: mode-colored arrow on the statusline background
    vim.api.nvim_set_hl(0, "St_" .. mode .. "ModeSep", { fg = color, bg = stl_bg })
    -- text block (used by the minimal stl theme): mode-colored text on stl bg
    vim.api.nvim_set_hl(0, "St_" .. mode .. "ModeText", { fg = color, bg = stl_bg, bold = true })
  end

  local file_color = fg("Type", "#f9e2af")
  vim.api.nvim_set_hl(0, "St_file", { fg = stl_fg, bg = stl_bg })
  vim.api.nvim_set_hl(0, "St_file_sep", { fg = stl_bg, bg = stl_bg })
  vim.api.nvim_set_hl(0, "St_file_bg", { fg = stl_bg, bg = file_color, bold = true })
  vim.api.nvim_set_hl(0, "St_file_txt", { fg = file_color, bg = stl_bg })

  vim.api.nvim_set_hl(0, "St_gitIcons", { fg = fg("Type", "#f9e2af"), bg = stl_bg })
  vim.api.nvim_set_hl(0, "St_LspMsg", { fg = fg("String", "#a6e3a1"), bg = stl_bg })
  vim.api.nvim_set_hl(0, "St_Lsp", { fg = fg("Function", "#89b4fa"), bg = stl_bg })

  local cwd_color = fg("Directory", "#94e2d5")
  vim.api.nvim_set_hl(0, "St_cwd_icon", { fg = cwd_color, bg = stl_bg })
  vim.api.nvim_set_hl(0, "St_cwd_text", { fg = stl_fg, bg = stl_bg })
  vim.api.nvim_set_hl(0, "St_cwd_sep", { fg = cwd_color, bg = stl_bg })
  vim.api.nvim_set_hl(0, "St_cwd_bg", { fg = stl_bg, bg = cwd_color, bold = true })
  vim.api.nvim_set_hl(0, "St_cwd_txt", { fg = cwd_color, bg = stl_bg })

  local pos_color = fg("Function", "#89b4fa")
  vim.api.nvim_set_hl(0, "St_pos_sep", { fg = pos_color, bg = stl_bg })
  vim.api.nvim_set_hl(0, "St_pos_icon", { fg = stl_bg, bg = pos_color, bold = true })
  vim.api.nvim_set_hl(0, "St_pos_text", { fg = stl_bg, bg = pos_color })
  vim.api.nvim_set_hl(0, "St_Pos_sep", { fg = pos_color, bg = stl_bg })
  vim.api.nvim_set_hl(0, "St_Pos_bg", { fg = stl_bg, bg = pos_color, bold = true })
  vim.api.nvim_set_hl(0, "St_Pos_txt", { fg = pos_color, bg = stl_bg })

  vim.api.nvim_set_hl(0, "St_sep_r", { fg = stl_bg, bg = stl_bg })
  vim.api.nvim_set_hl(0, "ST_EmptySpace", { fg = stl_bg, bg = stl_bg })
end

-- Style NvCheatsheet (<leader>ch). Cards use `nvchsection` for their background,
-- and each section heading is one of `NvChHead<color>` randomly. Without base46
-- these were all undefined, so the cheatsheet rendered as plain text.
local function style_cheatsheet()
  local function hl(name)
    return vim.api.nvim_get_hl(0, { name = name, link = false }) or {}
  end
  local function fg(name, fallback)
    return hl(name).fg or fallback
  end

  local normal = hl "Normal"
  local normal_bg = normal.bg or "#1e1e2e"
  local card_bg = hl("CursorLine").bg or hl("ColorColumn").bg or "#27273a"

  -- Card background — the rectangular block each section sits on.
  vim.api.nvim_set_hl(0, "nvchsection", { bg = card_bg })

  -- Big ASCII "CHEATSHEET" banner.
  vim.api.nvim_set_hl(0, "NvChAsciiHeader", { fg = fg("Function", "#89b4fa"), bold = true })

  -- Section heading chips. Bright bg, dark fg, bold for legibility.
  local chip_colors = {
    blue = fg("Function", "#89b4fa"),
    red = fg("DiagnosticError", "#f38ba8"),
    green = fg("String", "#a6e3a1"),
    yellow = fg("Type", "#f9e2af"),
    orange = fg("Constant", "#fab387"),
    baby_pink = fg("Tag", "#f5c2e7"),
    purple = fg("Statement", "#cba6f7"),
    white = fg("Normal", "#cdd6f4"),
    cyan = fg("Special", "#94e2d5"),
    vibrant_green = fg("DiagnosticOk", "#a6e3a1"),
    teal = fg("Identifier", "#94e2d5"),
  }
  for name, color in pairs(chip_colors) do
    vim.api.nvim_set_hl(0, "NvChHead" .. name, { fg = normal_bg, bg = color, bold = true })
  end
end

-- Style NvChad's tabufline so the currently focused buffer stands out.
local function style_tabufline()
  local function hl(name)
    return vim.api.nvim_get_hl(0, { name = name, link = false }) or {}
  end
  local function fg(name, fallback)
    return hl(name).fg or fallback
  end

  local normal = hl "Normal"
  local normal_bg = normal.bg or "#1e1e2e"
  local normal_fg = normal.fg or "#cdd6f4"
  local dim_fg = fg("Comment", "#7f849c")
  local inactive_bg = hl("CursorLine").bg or hl("ColorColumn").bg or normal_bg
  local accent = fg("Function", "#89b4fa")

  -- Active buffer: bright accent bar with normal fg.
  vim.api.nvim_set_hl(0, "TbBufOn", { fg = normal_fg, bg = inactive_bg, bold = true })
  vim.api.nvim_set_hl(0, "TbBufOnClose", { fg = fg("DiagnosticError", "#f38ba8"), bg = inactive_bg })
  vim.api.nvim_set_hl(0, "TbBufOnModified", { fg = fg("WarningMsg", "#f9e2af"), bg = inactive_bg })

  -- Inactive buffers: dim fg on the tabline background.
  vim.api.nvim_set_hl(0, "TbBufOff", { fg = dim_fg, bg = "NONE" })
  vim.api.nvim_set_hl(0, "TbBufOffClose", { fg = dim_fg, bg = "NONE" })
  vim.api.nvim_set_hl(0, "TbBufOffModified", { fg = fg("WarningMsg", "#f9e2af"), bg = "NONE" })

  -- Accent strip on the left edge of the active tab to make it pop.
  vim.api.nvim_set_hl(0, "TbBufOnIndicator", { fg = accent, bg = inactive_bg, bold = true })

  vim.api.nvim_set_hl(0, "TbFill", { bg = "NONE" })
end

autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("OmarchyTransparency", { clear = true }),
  callback = function()
    for _, group in ipairs(transparent_groups) do
      vim.api.nvim_set_hl(0, group, { bg = "none" })
    end
    vim.api.nvim_set_hl(0, "IblIndent", { fg = "#2a2b3d", bg = "none" })
    vim.api.nvim_set_hl(0, "IblScope", { fg = "#4ebfe3", bg = "none", bold = true })
    style_statusline()
    style_cheatsheet()
    style_tabufline()
  end,
})
