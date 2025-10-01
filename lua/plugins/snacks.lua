return {
	"folke/snacks.nvim",
	lazy = false,
	opts = {
		bufDelete = {},
		quickfile = {},
		indent = {},
		statuscolumn = {},
		scope = {},
		picker = {},
		input = {},
		notifier = {},
		terminal = {},
		lazygit = {},
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
			"<leader>e",
			function()
				Snacks.explorer()
			end,
			desc = "explorer",
		},
		{
			"<C-b>",
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
			"<C-t>",
			function()
				Snacks.terminal.toggle()
			end,
			desc = "open terminal",
			mode = { "n" },
		},
		{
			"<C-t>",
			function()
				Snacks.terminal.toggle()
			end,
			desc = "open terminal",
			mode = { "t" },
		},
	},
}
