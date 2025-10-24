require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
--
map("n", "ö", "$", { desc = "Jump to end of line" })
map("n", "ä", "0", { desc = "Jump to start of line" })

map("v", "ö", "$", { desc = "Jump to end of line" })
map("v", "ä", "0", { desc = "Jump to start of line" })


map("n","m",":m +1 <CR>",{desc= "Move down"})
map("n","n",":m -2 <CR>",{desc= "Move Up"})
map("v","n",":m -2 <CR>",{desc= "Move Up"})

-- Additional custom mappings
map("n", "<leader>ee", function()
  vim.api.nvim_put({ "if err != nil {", "  return err", "}" }, "", true, true)
end, { desc = "Insert Go error check" })

map("i", "<C-h>", "<Left>")
map("i", "<C-j>", "<Down>", { desc = "Move down in insert mode" })
map("i", "<C-k>", "<Up>", { desc = "Move up in insert mode" })
map("i", "<C-l>", "<Right>", { desc = "Move right in insert mode" })
