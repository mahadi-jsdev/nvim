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
		lazygit = {},
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
			"<leader>fb",
			function()
				Snacks.picker.buffers()
			end,
			desc = "buffers",
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
			"<C-l>",
			function()
				Snacks.picker.lines()
			end,
			desc = "Grep",
			mode = { "n" },
		},
		{
			"<C-g>",
			function()
				Snacks.picker.git_status()
			end,
			desc = "Git Status",
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
