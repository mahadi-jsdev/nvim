return {
	"olimorris/codecompanion.nvim",
	version = "^18.0.0",
	event = "VeryLazy",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		{
			"HakonHarnes/img-clip.nvim",
			event = "VeryLazy",
			opts = {
				default = {
					embed_image_as_base64 = false,
					prompt_for_file_name = false,
					drag_and_drop = { insert_mode = true },
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
		{ "<leader>cc", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "Toggle Chat" },
		{ "<leader>ca", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "CodeCompanion Actions" },
		-- Quick way to accept diffs when using /inline
		{ "ga", "<cmd>CodeCompanionChat Add<cr>", mode = "v", desc = "Add Selection to Chat" },
	},
	opts = {
		strategies = {
			chat = {
				adapter = "copilot",
				keymaps = {
					send = { modes = { n = "<CR>", i = "<C-s>" } },
					close = { modes = { n = "q" } },
				},
			},
			inline = {
				adapter = "copilot",
				keymaps = {
					accept_change = { modes = { n = "ga" }, description = "Accept Diff" },
					reject_change = { modes = { n = "gr" }, description = "Reject Diff" },
				},
			},
		},
		display = {
			chat = {
				show_settings = true,
				window = {
					layout = "vertical",
					position = "right",
					width = 0.40,
					border = "rounded",
				},
			},
		},
	},
}
