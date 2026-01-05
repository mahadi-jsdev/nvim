return {
	"jake-stewart/multicursor.nvim",
	branch = "1.0",
	event = "BufRead",
	config = function()
		local map = vim.keymap.set
		local mc = require("multicursor-nvim")
		mc.setup()

		-- Add and remove cursors with alt + left click.
		map("n", "<M-leftmouse>", mc.handleMouse)
		map("x", "<C-o>", function()
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
