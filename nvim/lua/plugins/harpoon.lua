return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    lazy = false,
    config = function()
      local harpoon = require "harpoon"
      harpoon:setup {}
      -- Telescope integration
      local conf = require("telescope.config").values
      local function toggle_telescope(harpoon_files)
        local conf = require("telescope.config").values
        local pickers = require "telescope.pickers"
        local finders = require "telescope.finders"
        local actions = require "telescope.actions"
        local action_state = require "telescope.actions.state"
        local file_paths = {}
        for _, item in ipairs(harpoon_files.items) do
          table.insert(file_paths, item.value)
        end
        pickers
          .new({}, {
            prompt_title = "Harpoon",
            finder = finders.new_table {
              results = file_paths,
            },
            previewer = conf.file_previewer {},
            sorter = conf.generic_sorter {},
            attach_mappings = function(prompt_bufnr, map)
              -- Open the selected file
              map("i", "<CR>", function()
                local selection = action_state.get_selected_entry()
                actions.close(prompt_bufnr)
                for i, item in ipairs(harpoon_files.items) do
                  if item.value == selection.value then
                    harpoon:list():select(i)
                    return
                  end
                end
              end)
              map("n", "<CR>", function()
                local selection = action_state.get_selected_entry()
                actions.close(prompt_bufnr)
                for i, item in ipairs(harpoon_files.items) do
                  if item.value == selection.value then
                    harpoon:list():select(i)
                    return
                  end
                end
              end)
              -- 🗑 Delete the selected file from Harpoon (FIXED)
              map({ "i", "n" }, "<C-d>", function()
                local selection = action_state.get_selected_entry()
                local removed_file = selection.value

                -- Remove the file
                for i, item in ipairs(harpoon_files.items) do
                  if item.value == selection.value then
                    harpoon:list():remove_at(i)
                    break
                  end
                end

                -- Reorder/normalize the list to fix indexing
                local items = harpoon:list().items
                harpoon:list():clear()
                for _, item in ipairs(items) do
                  harpoon:list():add(item)
                end

                vim.notify("Removed from Harpoon: " .. removed_file, vim.log.levels.INFO)

                -- Close and refresh picker
                actions.close(prompt_bufnr)
                vim.schedule(function()
                  toggle_telescope(harpoon:list())
                end)
              end)
              return true
            end,
          })
          :find()
      end
      -- Keymaps (FIXED)
      vim.keymap.set("n", "<leader>a", function()
        local filename = vim.fn.expand "%:t" -- Get just the filename
        harpoon:list():add()
        vim.notify("Added to Harpoon: " .. filename, vim.log.levels.INFO)
      end, { desc = "Add file to Harpoon" })
      -- vim.keymap.set("n", "<leader>d", function() harpoon:list():remove() end, { desc = "remove from Harpoon" })
      vim.keymap.set("n", "<C-e>", function()
        toggle_telescope(harpoon:list())
      end, { desc = "Open Harpoon Telescope menu" })
      vim.keymap.set("n", "<C-1>", function()
        harpoon:list():select(1)
      end, { desc = "Harpoon to file 1" })
      vim.keymap.set("n", "<C-2>", function()
        harpoon:list():select(2)
      end, { desc = "Harpoon to file 2" })
      vim.keymap.set("n", "<C-3>", function()
        harpoon:list():select(3)
      end, { desc = "Harpoon to file 3" })
      vim.keymap.set("n", "<C-4>", function()
        harpoon:list():select(4)
      end, { desc = "Harpoon to file 4" })
    end,
  },
}
