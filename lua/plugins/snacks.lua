-- Snacks for features that telescope doesn't handle
return {
	"folke/snacks.nvim",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		bigfile = {},
		quickfile = {},
		bufDelete = {},
		statuscolumn = {},
		scope = {},
		input = {},
		notifier = {},
		picker = {},
		indent = {},
		explorer = {},
		dashboard = {},
		-- image = {},
	},
	keys = {
		{
			"<leader>e",
			function()
				Snacks.explorer()
			end,
			desc = "explorer",
		},
		{
			"<C-x>",
			function()
				Snacks.bufdelete()
			end,
			desc = "Delete Buffer",
		},
	},
}
