require "nvchad.mappings"

-- add yours here
local map = vim.keymap.set

-- Normal mode (n)
-- Default mode — for navigation and commands, not typing text.
map("n", ";", ":", { desc = "CMD enter command mode" })

map("n", "ö", "$", { desc = "Jump to end of line" })
map("n", "ä", "0", { desc = "Jump to start of line" })

map("n", "m", ":m +1 <CR>", { desc = "Move down" })
map("n", "n", ":m -2 <CR>", { desc = "Move Up" })

map("n", "<leader>lr", ":LspRestart <CR>", { desc = "Reset lsp" })

-- Buffer management mappings
map("n", "<leader>bx", function()
  local ok = pcall(vim.cmd, "bufdo bd")
  if not ok then
    vim.notify("Some buffers have unsaved changes!", vim.log.levels.WARN)
  end
end, { desc = "Close all buffers (safe)" })

map("n", "<leader>bo", function()
  vim.cmd "%bd|e#|bd#"
end, { desc = "Close all buffers except current" })

-- Additional custom mappings
map("n", "<leader>ee", function()
  vim.api.nvim_put({ "if err != nil {", "  return err", "}" }, "", true, true)
end, { desc = "Insert Go error check" })

-- Insert mode (i)
-- For typing text, like a normal editor.
map("i", "jk", "<ESC>")
map("i", "<C-h>", "<Left>")
map("i", "<C-j>", "<Down>", { desc = "Move down in insert mode" })
map("i", "<C-k>", "<Up>", { desc = "Move up in insert mode" })
map("i", "<C-l>", "<Right>", { desc = "Move right in insert mode" })

-- Visual mode (v)
-- For selecting text.
map("v", "n", ":m -2 <CR>", { desc = "Move Up" })
map("v", "ö", "$", { desc = "Jump to end of line" })
map("v", "ä", "0", { desc = "Jump to start of line" })
