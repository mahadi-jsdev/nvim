return {
	"olimorris/codecompanion.nvim",
	version = "^18.0.0",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		{
			"HakonHarnes/img-clip.nvim",
			event = "VeryLazy",
			opts = {
				-- recommended settings
				default = {
					embed_image_as_base64 = false,
					prompt_for_file_name = false,
					drag_and_drop = {
						insert_mode = true,
					},
				},
			},
		},
		{
			"MeanderingProgrammer/render-markdown.nvim",
			opts = {
				file_types = { "markdown", "codecompanion" },
			},
			ft = { "markdown", "codecompanion" },
		},
	},
	keys = {

		{
			"<leader>cc",
			"<cmd>CodeCompanionChat<cr>",
			mode = { "n", "v" },
			desc = "Toggle CodeCompanion Sidebar",
		},
		{
			"<leader>ca",
			"<cmd>CodeCompanionActions<cr>",
			mode = { "n", "v" },
			desc = "Toggle CodeCompanion Sidebar",
		},
	},
	opts = {
		strategies = {
			chat = {
				adapter = "copilot",
			},
		},
		display = {
			chat = {
				window = {
					layout = "vertical",
					position = "right",
					width = 0.4,
				},
			},
		},
	},
}
