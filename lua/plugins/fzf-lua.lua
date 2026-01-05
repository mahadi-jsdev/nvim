return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		fzf_opts = { ["--layout"] = "reverse" },
		winopts = {
			height = 0.85,
			width = 0.80,
			row = 0.35,
			preview = {
				layout = "horizontal", -- or 'horizontal'
			},
		},
	},
	keys = {
		{
			"<leader><leader>",
			function()
				require("fzf-lua").files()
			end,
			desc = "Search Files",
		},
		{
			"<C-space>",
			function()
				require("fzf-lua").buffers()
			end,
			desc = "Buffers",
		},
		{
			"<C-/>",
			function()
				require("fzf-lua").live_grep()
			end,
			desc = "Grep",
			mode = { "n" },
		},
		{
			"<C-/>",
			function()
				require("fzf-lua").grep_visual()
			end,
			desc = "Grep Visual Selection",
			mode = { "x" },
		},
		{
			"<C-f>",
			function()
				require("fzf-lua").blines()
			end,
			desc = "Fuzzy Find in Buffer",
			mode = { "n" },
		},
		{
			"<C-g>",
			function()
				require("fzf-lua").git_status()
			end,
			desc = "Git Status",
		},
	},
	config = function(_, opts)
		local fzf = require("fzf-lua")
		fzf.setup(opts) -- Apply the options from the 'opts' table below
		fzf.register_ui_select() -- This replaces the native Neovim UI menus
	end,
}
