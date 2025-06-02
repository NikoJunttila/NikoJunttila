-- Minimal fugitive config
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Essential Git commands
keymap("n", "<leader>gs", ":Git<CR>", opts)          -- Git status
keymap("n", "<leader>ga", ":Git add %<CR>", opts)    -- Add current file
keymap("n", "<leader>gc", ":Git commit<CR>", opts)   -- Commit
keymap("n", "<leader>gp", ":Git push<CR>", opts)     -- Push
keymap("n", "<leader>gl", ":Git log --oneline<CR>", opts) -- Log
keymap("n", "<leader>gd", ":Gdiffsplit<CR>", opts)   -- Diff
