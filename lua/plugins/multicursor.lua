return {
	"jake-stewart/multicursor.nvim",
	event = "BufRead",
	branch = "1.0",
	config = function()
		local map = vim.keymap.set
		local mc = require("multicursor-nvim")
		mc.setup()

		-- Add and remove cursors with alt + left click.
		map("n", "<M-leftmouse>", mc.handleMouse)
		map("x", "<C-m>", function()
			mc.matchAddCursor(1)
		end)

		-- Mappings defined in a keymap layer only apply when there are
		-- multiple cursors. This lets you have overlapping mappings.
		mc.addKeymapLayer(function(layerSet)
			layerSet("n", "<esc>", function()
				if not mc.cursorsEnabled() then
					mc.enableCursors()
				else
					mc.clearCursors()
				end
			end)
		end)
	end,
}
