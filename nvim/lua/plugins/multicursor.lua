return {
  {
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    keys = {
      { "<up>", function() require("multicursor-nvim").lineAddCursor(-1) end, mode = { "n", "x" }, desc = "MultiCursor Add Above" },
      { "<down>", function() require("multicursor-nvim").lineAddCursor(1) end, mode = { "n", "x" }, desc = "MultiCursor Add Below" },
      { "<leader><up>", function() require("multicursor-nvim").lineSkipCursor(-1) end, mode = { "n", "x" }, desc = "MultiCursor Skip Above" },
      { "<leader><down>", function() require("multicursor-nvim").lineSkipCursor(1) end, mode = { "n", "x" }, desc = "MultiCursor Skip Below" },
      { "<leader>n", function() require("multicursor-nvim").matchAddCursor(1) end, mode = { "n", "x" }, desc = "MultiCursor Match Add" },
      { "<leader>s", function() require("multicursor-nvim").matchSkipCursor(1) end, mode = { "n", "x" }, desc = "MultiCursor Match Skip" },
      { "<leader>N", function() require("multicursor-nvim").matchAddCursor(-1) end, mode = { "n", "x" }, desc = "MultiCursor Match Add Reverse" },
      { "<leader>S", function() require("multicursor-nvim").matchSkipCursor(-1) end, mode = { "n", "x" }, desc = "MultiCursor Match Skip Reverse" },
      { "<leader>a", function() require("multicursor-nvim").matchAllAddCursors() end, mode = { "n", "x" }, desc = "MultiCursor Match All" },
      { "<c-leftmouse>", function() require("multicursor-nvim").handleMouse() end, mode = "n", desc = "MultiCursor Handle Mouse" },
      { "<c-leftdrag>", function() require("multicursor-nvim").handleMouseDrag() end, mode = "n", desc = "MultiCursor Handle Mouse Drag" },
      { "<c-leftrelease>", function() require("multicursor-nvim").handleMouseRelease() end, mode = "n", desc = "MultiCursor Handle Mouse Release" },
      { "<c-q>", function() require("multicursor-nvim").toggleCursor() end, mode = { "n", "x" }, desc = "MultiCursor Toggle" },
    },
    config = function()
        local mc = require("multicursor-nvim")
        mc.setup()
        
        -- Mappings defined in a keymap layer only apply when there are
        -- multiple cursors. This lets you have overlapping mappings.
        mc.addKeymapLayer(function(layerSet)
            -- Select a different cursor as the main one.
            layerSet({"n", "x"}, "<left>", mc.prevCursor)
            layerSet({"n", "x"}, "<right>", mc.nextCursor)
            -- Enable and clear cursors using escape.
            layerSet("n", "<esc>", function()
                if not mc.cursorsEnabled() then
                    mc.enableCursors()
                else
                    mc.clearCursors()
                end
            end)
        end)
        -- Customize how cursors look.
        local hl = vim.api.nvim_set_hl
        hl(0, "MultiCursorCursor", { reverse = true })
        hl(0, "MultiCursorVisual", { link = "Visual" })
        hl(0, "MultiCursorSign", { link = "SignColumn"})
        hl(0, "MultiCursorMatchPreview", { link = "Search" })
        hl(0, "MultiCursorDisabledCursor", { reverse = true })
        hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
        hl(0, "MultiCursorDisabledSign", { link = "SignColumn"})
    end
  },
}
