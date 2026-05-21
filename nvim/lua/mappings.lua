local map = vim.keymap.set

-- Normal mode (n)
-- Default mode — for navigation and commands, not typing text.
map("n", ";", ":", { desc = "CMD enter command mode" })

map("n", "ö", "$", { desc = "Jump to end of line" })
map("n", "ä", "0", { desc = "Jump to start of line" })

map("n", "<A-m>", ":m +1 <CR>", { desc = "Move line down" })
map("n", "<A-n>", ":m -2 <CR>", { desc = "Move line up" })

map("n", "<leader>lr", "<cmd>lsp restart<CR>", { desc = "Restart LSP" })
map("n", "<leader>ls", "<cmd>lsp stop<CR>", { desc = "Stop LSP" })
map("n", "<leader>lh", "<cmd>checkhealth lsp<CR>", { desc = "LSP info/health" })

-- Buffer management mappings
map("n", "<leader>bx", function() Snacks.bufdelete.all() end, { desc = "Close all buffers" })
map("n", "<leader>bo", function() Snacks.bufdelete.other() end, { desc = "Close all buffers except current" })

-- Additional custom mappings
map("n", "<leader>ee", function()
  vim.api.nvim_put({ "if err != nil {", "  return err", "}" }, "", true, true)
end, { desc = "Insert Go error check" })

-- Insert mode (i)
-- For typing text, like a normal editor.
map("i", "jk", "<ESC>")
map("i", "<C-j>", "<Down>", { desc = "Move down in insert mode" })
map("i", "<C-k>", "<Up>", { desc = "Move up in insert mode" })
map("i", "<C-l>", "<Right>", { desc = "Move right in insert mode" })

-- Visual mode (v)
-- For selecting text.
map("v", "<A-n>", ":m -2 <CR>", { desc = "Move line up" })
map("v", "<A-m>", ":m +1 <CR>", { desc = "Move line down" })
map("v", "ö", "$", { desc = "Jump to end of line" })
map("v", "ä", "0", { desc = "Jump to start of line" })

-- NVCHAD binding
map("i", "<C-b>", "<ESC>^i", { desc = "move beginning of line" })
map("i", "<C-e>", "<End>", { desc = "move end of line" })
map("i", "<C-h>", "<Left>", { desc = "move left" })
map("i", "<C-l>", "<Right>", { desc = "move right" })
map("i", "<C-j>", "<Down>", { desc = "move down" })
map("i", "<C-k>", "<Up>", { desc = "move up" })

map("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
map("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
map("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
map("n", "<C-k>", "<C-w>k", { desc = "switch window up" })

map("n", "<Esc>", "<cmd>noh<CR>", { desc = "general clear highlights" })

map("n", "<C-s>", "<cmd>w<CR>", { desc = "general save file" })

map("n", "<leader>tn", "<cmd>set nu!<CR>", { desc = "toggle line number" })
map("n", "<leader>rn", "<cmd>set rnu!<CR>", { desc = "toggle relative number" })
map("n", "<leader>ch", "<cmd>NvCheatsheet<CR>", { desc = "toggle nvcheatsheet" })

map({ "n", "x" }, "<leader>fm", function()
  local conform = require "conform"
  conform.format { lsp_fallback = true }
end, { desc = "general format file" })

map("n", "<leader>ra", require "nvchad.lsp.renamer", { desc = "NvRenamer" })
-- global lsp mappings
map("n", "<leader>ds", function() Snacks.picker.diagnostics() end, { desc = "LSP diagnostics picker" })

-- tabufline
if require("nvconfig").ui.tabufline.enabled then
  map("n", "<leader>b", "<cmd>enew<CR>", { desc = "buffer new" })

  map("n", "<tab>", function()
    require("nvchad.tabufline").next()
  end, { desc = "buffer goto next" })

  map("n", "<S-tab>", function()
    require("nvchad.tabufline").prev()
  end, { desc = "buffer goto prev" })

  map("n", "<leader>x", function() Snacks.bufdelete() end, { desc = "buffer close" })
end

-- Comment
map("n", "<leader>/", "gcc", { desc = "toggle comment", remap = true })
map("v", "<leader>/", "gc", { desc = "toggle comment", remap = true })

-- file explorer (snacks.explorer)
map("n", "<C-n>", function() Snacks.explorer() end, { desc = "explorer toggle" })
map("n", "<leader>e", function() Snacks.explorer.reveal() end, { desc = "explorer reveal current file" })

-- pickers (snacks.picker)
map("n", "<leader>fw", function() Snacks.picker.grep() end, { desc = "grep" })
map("n", "<leader>fb", function() Snacks.picker.buffers() end, { desc = "buffers" })
map("n", "<leader>fh", function() Snacks.picker.help() end, { desc = "help pages" })
map("n", "<leader>ma", function() Snacks.picker.marks() end, { desc = "marks" })
map("n", "<leader>fo", function() Snacks.picker.recent() end, { desc = "recent files" })
map("n", "<leader>fz", function() Snacks.picker.lines() end, { desc = "buffer lines" })
map("n", "<leader>cm", function() Snacks.picker.git_log() end, { desc = "git log" })
map("n", "<leader>gt", function() Snacks.picker.git_status() end, { desc = "git status" })
map("n", "<leader>ff", function() Snacks.picker.files() end, { desc = "find files" })
map("n", "<leader>fa", function()
  Snacks.picker.files { hidden = true, ignored = true, follow = true }
end, { desc = "find files (hidden + ignored)" })

-- terminal (snacks.terminal)
map("t", "<C-x>", "<C-\\><C-N>", { desc = "terminal escape terminal mode" })

map("n", "<leader>h", function()
  Snacks.terminal.open(nil, { win = { position = "bottom" } })
end, { desc = "new horizontal terminal" })

map("n", "<leader>v", function()
  Snacks.terminal.open(nil, { win = { position = "right" } })
end, { desc = "new vertical terminal" })

map({ "n", "t" }, "<A-v>", function()
  Snacks.terminal.toggle(nil, { win = { position = "right" }, count = 2 })
end, { desc = "toggle vertical terminal" })

map({ "n", "t" }, "<A-h>", function()
  Snacks.terminal.toggle(nil, { win = { position = "bottom" }, count = 1 })
end, { desc = "toggle horizontal terminal" })

map({ "n", "t" }, "<A-i>", function()
  Snacks.terminal.toggle(nil, { win = { position = "float" }, count = 3 })
end, { desc = "toggle floating terminal" })

-- whichkey
map("n", "<leader>wK", "<cmd>WhichKey <CR>", { desc = "whichkey all keymaps" })

map("n", "<leader>wk", function()
  vim.cmd("WhichKey " .. vim.fn.input "WhichKey: ")
end, { desc = "whichkey query lookup" })

-- map("i", "<A-f>", require("neocodeium").accept)
