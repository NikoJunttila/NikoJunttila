local function harpoon_picker()
  local harpoon = require "harpoon"
  local list = harpoon:list()

  local items = {}
  for i, item in ipairs(list.items) do
    table.insert(items, {
      idx = i,
      text = item.value,
      file = item.value,
    })
  end

  Snacks.picker.pick {
    source = "harpoon",
    items = items,
    format = "file",
    title = "Harpoon",
    layout = { preset = "select" },
    confirm = function(picker, item)
      picker:close()
      if item then
        harpoon:list():select(item.idx)
      end
    end,
    actions = {
      delete_harpoon = function(picker, item)
        if not item then
          return
        end
        local removed_file = item.file
        harpoon:list():remove_at(item.idx)
        local kept = harpoon:list().items
        harpoon:list():clear()
        for _, it in ipairs(kept) do
          harpoon:list():add(it)
        end
        vim.notify("Removed from Harpoon: " .. removed_file, vim.log.levels.INFO)
        picker:close()
        vim.schedule(harpoon_picker)
      end,
    },
    win = {
      input = {
        keys = {
          ["<C-d>"] = { "delete_harpoon", mode = { "n", "i" } },
        },
      },
    },
  }
end

return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
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
      { "<C-e>", harpoon_picker, desc = "Open Harpoon picker" },
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
