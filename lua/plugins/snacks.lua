return {
	"folke/snacks.nvim",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		lazy = true,
	},
	opts = {
		bufDelete = {},
		indent = {},
		statuscolumn = {},
		scope = {},
		picker = {},
		input = {},
		notifier = {},
		dashboard = {},
		terminal = {},
		lazygit = {},
		scroll = {},
		words = {},
		zen = {},
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
			desc = "file explorer",
		},
		{
			"<C-space>",
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
			"<leader>fl",
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
			"<leader>gg",
			function()
				Snacks.lazygit()
			end,
			desc = "Lazygit",
		},
		{
			"<C-`>",
			function()
				Snacks.terminal()
			end,
			mode = { "n", "t" },
			desc = "Toggle Terminal",
		},
		{
			"<C-Right>",
			function()
				Snacks.words.jump(1)
			end,
			desc = "Next reference",
		},
		{
			"<C-Left>",
			function()
				Snacks.words.jump(-1)
			end,
			desc = "Prev reference",
		},
		{
			"<leader>zz",
			function()
				Snacks.zen()
			end,
			desc = "Zen mode",
		},
	},
}
