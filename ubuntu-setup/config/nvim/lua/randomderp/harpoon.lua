local status_ok, harpoon = pcall(require, "harpoon")
if not status_ok then
  return
end

-- Setup harpoon
harpoon:setup({
  settings = {
    save_on_toggle = false,
    sync_on_ui_close = false,
    save_on_change = true,
    enter_on_sendcmd = false,
    tmux_autoclose_windows = false,
    excluded_filetypes = { "harpoon", "alpha", "dashboard", "gitcommit" },
    mark_branch = false,
    key = function()
      return vim.loop.cwd()
    end
  }
})

-- Key mappings
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Add current file to harpoon
keymap("n", "<leader>a", function() harpoon:list():add() end, opts)

-- Toggle harpoon quick menu
keymap("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, opts)

-- Navigate to files
keymap("n", "<C-h>", function() harpoon:list():select(1) end, opts)
keymap("n", "<C-t>", function() harpoon:list():select(2) end, opts)
keymap("n", "<C-n>", function() harpoon:list():select(3) end, opts)
keymap("n", "<C-s>", function() harpoon:list():select(4) end, opts)

-- Toggle previous & next buffers stored within Harpoon list
keymap("n", "<C-S-P>", function() harpoon:list():prev() end, opts)
keymap("n", "<C-S-N>", function() harpoon:list():next() end, opts)

-- Alternative navigation (using leader)
keymap("n", "<leader>1", function() harpoon:list():select(1) end, opts)
keymap("n", "<leader>2", function() harpoon:list():select(2) end, opts)
keymap("n", "<leader>3", function() harpoon:list():select(3) end, opts)
keymap("n", "<leader>4", function() harpoon:list():select(4) end, opts)
keymap("n", "<leader>5", function() harpoon:list():select(5) end, opts)

-- Replace file in harpoon list
keymap("n", "<leader>r1", function() harpoon:list():replace_at(1) end, opts)
keymap("n", "<leader>r2", function() harpoon:list():replace_at(2) end, opts)
keymap("n", "<leader>r3", function() harpoon:list():replace_at(3) end, opts)
keymap("n", "<leader>r4", function() harpoon:list():replace_at(4) end, opts)

-- Remove current file from harpoon
keymap("n", "<leader>x", function() harpoon:list():remove() end, opts)

-- Clear all harpoon marks
keymap("n", "<leader>X", function() harpoon:list():clear() end, opts)

-- Terminal commands (if you use harpoon for terminals)
keymap("n", "<leader>te", function() harpoon.ui:toggle_quick_menu(harpoon:list("term")) end, opts)
keymap("n", "<leader>ta", function() harpoon:list("term"):add() end, opts)
-- Add this to your harpoon config after the basic setup
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end

    require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
            results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
    }):find()
end

keymap("n", "<C-f>", function() toggle_telescope(harpoon:list()) end, { desc = "Open harpoon window" })
