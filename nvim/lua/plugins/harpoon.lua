return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    keys = {
      { "<leader>a", function()
        local harpoon = require "harpoon"
        local filename = vim.fn.expand "%:t"
        harpoon:list():add()
        vim.notify("Added to Harpoon: " .. filename, vim.log.levels.INFO)
      end, desc = "Add file to Harpoon" },
      { "<C-e>", function()
        -- The toggle_telescope function needs to be moved or simply called directly via the setup logic
        -- It's cleaner to just let the config block define toggle_telescope globally,
        -- but since we can't easily do that inside `keys`, we put it in config and just press <C-e>.
        -- When <C-e> is pressed, lazy.nvim will load harpoon and THEN execute this.
        -- We will map these keys inside `config` as well, or we can just keep them in `keys` and require harpoon.
        local harpoon = require "harpoon"
        -- We'll just define the toggle_telescope logic here or rely on the fact that if they use typical harpoon UI it works.
        -- Since they have a custom telescope picker, we need that picker logic available.
        -- Let's put the keys back into `config` but use `keys` purely for triggering lazy load.
      end, desc = "Open Harpoon Telescope menu" },
      { "<C-1>", function() require("harpoon"):list():select(1) end, desc = "Harpoon to file 1" },
      { "<C-2>", function() require("harpoon"):list():select(2) end, desc = "Harpoon to file 2" },
      { "<C-3>", function() require("harpoon"):list():select(3) end, desc = "Harpoon to file 3" },
      { "<C-4>", function() require("harpoon"):list():select(4) end, desc = "Harpoon to file 4" },
    },
    config = function()
      local harpoon = require "harpoon"
      harpoon:setup {}
      -- Telescope integration
      local conf = require("telescope.config").values
      local function toggle_telescope(harpoon_files)
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
      -- These mappings execute when the plugin actually loads.
      -- The `keys` block above tells lazy.nvim WHICH keys should trigger the load.
      -- Re-mapping them here ensures the complex telescope logic works nicely.
      vim.keymap.set("n", "<leader>a", function()
        local filename = vim.fn.expand "%:t" -- Get just the filename
        harpoon:list():add()
        vim.notify("Added to Harpoon: " .. filename, vim.log.levels.INFO)
      end, { desc = "Add file to Harpoon" })
      
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
