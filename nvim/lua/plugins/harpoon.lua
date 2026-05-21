local function toggle_telescope(harpoon_files)
  local harpoon = require "harpoon"
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
      finder = finders.new_table { results = file_paths },
      previewer = conf.file_previewer {},
      sorter = conf.generic_sorter {},
      attach_mappings = function(prompt_bufnr, map)
        local select = function()
          local selection = action_state.get_selected_entry()
          actions.close(prompt_bufnr)
          for i, item in ipairs(harpoon_files.items) do
            if item.value == selection.value then
              harpoon:list():select(i)
              return
            end
          end
        end
        map("i", "<CR>", select)
        map("n", "<CR>", select)

        map({ "i", "n" }, "<C-d>", function()
          local selection = action_state.get_selected_entry()
          local removed_file = selection.value

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

return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    keys = {
      {
        "<leader>A",
        function()
          local filename = vim.fn.expand "%:t"
          require("harpoon"):list():add()
          vim.notify("Added to Harpoon: " .. filename, vim.log.levels.INFO)
        end,
        desc = "Add file to Harpoon",
      },
      {
        "<C-e>",
        function()
          toggle_telescope(require("harpoon"):list())
        end,
        desc = "Open Harpoon Telescope menu",
      },
      { "<C-1>", function() require("harpoon"):list():select(1) end, desc = "Harpoon to file 1" },
      { "<C-2>", function() require("harpoon"):list():select(2) end, desc = "Harpoon to file 2" },
      { "<C-3>", function() require("harpoon"):list():select(3) end, desc = "Harpoon to file 3" },
      { "<C-4>", function() require("harpoon"):list():select(4) end, desc = "Harpoon to file 4" },
    },
    config = function()
      require("harpoon"):setup {}
    end,
  },
}
