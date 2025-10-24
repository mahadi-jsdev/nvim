return {
	"andrewferrier/debugprint.nvim",
	lazy = false,
	version = "*",
	dependencies = {
		"folke/snacks.nvim",
	},
	opts = {
		keymaps = {
			normal = {
				variable_below = "<leader>lb",
			},
			visual = {
				variable_below = "<leader>lb",
			},
		},
	},
}
