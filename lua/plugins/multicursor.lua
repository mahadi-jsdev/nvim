local M = {}

function M.setup()
  local map = vim.keymap.set
  local mc = require("multicursor-nvim")
  mc.setup()

  map("n", "<M-leftmouse>", mc.handleMouse)
  map("x", "<C-m>", function()
    mc.matchAddCursor(1)
  end)

  mc.addKeymapLayer(function(layer_set)
    layer_set("n", "<esc>", function()
      if not mc.cursorsEnabled() then
        mc.enableCursors()
      else
        mc.clearCursors()
      end
    end)
  end)
end

return M
