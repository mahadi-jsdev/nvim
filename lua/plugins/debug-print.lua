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
				variable_below = "<C-p>",
			},
			visual = {
				variable_below = "<C-p>",
			},
		},
	},
}
