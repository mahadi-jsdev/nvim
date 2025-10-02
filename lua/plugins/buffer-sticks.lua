return {
	"ahkohd/buffer-sticks.nvim",
	event = "BufRead",
	keys = {
		{
			"<C-l>",
			function()
				BufferSticks.jump()
			end,
			desc = "Buffer jump mode",
		},
	},
	config = function()
		local bufferSticks = require("buffer-sticks")

		bufferSticks.setup({
			offset = { x = 0, y = 0 }, -- Position offset (positive moves inward from right edge)
			padding = { top = 0, right = 1, bottom = 0, left = 1 }, -- Padding inside the float
			active_char = "──", -- Character for active buffer
			inactive_char = " ─", -- Character for inactive buffers
			alternate_char = " ─", -- Character for alternate buffer
			active_modified_char = "──", -- Character for active modified buffer (unsaved changes)
			inactive_modified_char = " ─", -- Character for inactive modified buffers (unsaved changes)
			alternate_modified_char = " ─", -- Character for alternate modified buffer (unsaved changes)
			transparent = true, -- Remove background color (shows terminal/editor background)
			auto_hide = true, -- Auto-hide when cursor is over float (default: true)
			label = { show = "jump" }, -- Label display: "always", "jump", or "never"
			jump = { show = { "filename", "space", "label" } }, -- Jump mode display options
			-- winblend = 100,                    -- Window blend level (0-100, 0=opaque, 100=fully blended)
			-- filter = {
			--   filetypes = { "help", "qf" },    -- Exclude by filetype (also: "NvimTree", "neo-tree", "Trouble")
			--   buftypes = { "terminal" },       -- Exclude by buftype (also: "help", "quickfix", "nofile")
			--   names = { ".*%.git/.*", "^/tmp/.*" },  -- Exclude buffers matching lua patterns
			-- },
			filter = { buftypes = { "terminal" } },
			highlights = {
				active = { link = "Statement" },
				alternate = { link = "StorageClass" },
				inactive = { link = "Whitespace" },
				active_modified = { link = "Constant" },
				alternate_modified = { link = "Constant" },
				inactive_modified = { link = "Constant" },
				label = { link = "Comment" },
			},
		})

		bufferSticks.show()
	end,
}
