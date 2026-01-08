return {
	"folke/snacks.nvim",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		lazy = true,
	},
	opts = {
		picker = {},
		bigfile = {},
		quickfile = {},
		bufDelete = {},
		statuscolumn = {},
		scope = {},
		input = {},
		notifier = {},
		terminal = {},
		-- dashboard = {},
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
			"<C-space>",
			function()
				Snacks.picker.buffers()
			end,
			desc = "buffers",
		},
		{
			"<C-/>",
			function()
				Snacks.picker.grep()
			end,
			desc = "Grep",
			mode = { "n" },
		},
		{
			"<C-/>",
			function()
				Snacks.picker.grep_word()
			end,
			desc = "Visual selection or word",
			mode = { "x" },
		},
		{
			"<C-f>",
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
		{
			"<C-`>",
			function()
				Snacks.terminal()
			end,
			mode = { "n", "t" },
			desc = "Toggle Terminal",
		},
	},
}
