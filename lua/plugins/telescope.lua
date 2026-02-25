return {
	-- Telescope for fuzzy finding
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
	},
	config = function(_, opts)
		local telescope = require("telescope")
		telescope.setup(opts)
		telescope.load_extension("fzf")
	end,
	opts = {
		defaults = {
			layout_config = {
				prompt_position = "top",
			},
			sorting_strategy = "ascending",
		},
		pickers = {
			buffers = {
				sort_mru = true,
				sort_lastused = true,
				ignore_current_buffer = true,
			},
		},
	},
	keys = {
		{
			"<leader><leader>",
			function()
				require("telescope.builtin").find_files()
			end,
			desc = "search files",
		},
		{
			",",
			function()
				require("telescope.builtin").buffers()
			end,
			mode = { "n" },
			desc = "buffers",
		},
		{
			"<C-f>",
			function()
				require("telescope.builtin").live_grep()
			end,
			desc = "Grep",
			mode = { "n" },
		},
		{
			"<C-f>",
			function()
				require("telescope.builtin").grep_string()
			end,
			desc = "Visual selection or word",
			mode = { "x" },
		},
		{
			"<leader>fl",
			function()
				require("telescope.builtin").current_buffer_fuzzy_find()
			end,
			desc = "find lines",
			mode = { "n" },
		},
		{
			"<C-g>",
			function()
				require("telescope.builtin").git_status()
			end,
			desc = "Git Status",
		},
	},
}
