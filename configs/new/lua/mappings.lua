require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<leader>a", "gcc", { desc = "comment toggle", remap = true })
map("v", "<leader>a", "gc", { desc = "comment toggle", remap = true })
map("n","n",":m -2 <CR>",{desc= "Move Up"})
map("n","m",":m +1 <CR>",{desc= "Move down"})
map("v","n",":m -2 <CR>",{desc= "Move Up"})
-- idk how to do below
-- map("n","<leader>ee","{"oif err != nil {<CR>}<Esc>Oreturn err"}")
--["<leader>ee"] = {"oif err != nil {<CR>}<Esc>Oreturn err"},
