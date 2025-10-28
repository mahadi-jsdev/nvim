return {
	"folke/snacks.nvim",
	lazy = false,
	opts = {
		bufDelete = {},
		indent = {},
		statuscolumn = {},
		scope = {},
		picker = {},
		input = {},
		notifier = {},
		dashboard = {},
	},
	keys = {
		{
			"<leader><leader>",
			function()
				Snacks.picker.files()
			end,
			desc = "search files",
		},
		{
			"<C-f>",
			function()
				Snacks.picker.grep()
			end,
			desc = "Grep",
			mode = { "n" },
		},
		{
			"<C-f>",
			function()
				Snacks.picker.grep_word()
			end,
			desc = "Visual selection or word",
			mode = { "x" },
		},
		{
			"<leader>fl",
			function()
				Snacks.picker.lines()
			end,
			desc = "Grep",
			mode = { "n" },
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
