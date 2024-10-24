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

-- Add mouse button mappings
map("n", "ö", "$", { desc = "Jump to end of line" }) 
map("n", "ä", "0", { desc = "Jump to start of line" }) 

local M = {}
M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = {
      "<cmd> DapToggleBreakpoint <CR>",
      "Add breakpoint at line",
    },
    ["<leader>dr"] = {
      "<cmd> DapContinue <CR>",
      "Start or continue the debugger",
    },
    -- Add the error handling snippet
    ["<leader>re"] = {
      "oif err != nil {<CR>return err<CR>}<ESC>kk$",
      "Insert error handling snippet",
    },
  }
}
return M