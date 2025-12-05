return {
	"NeogitOrg/neogit",
	lazy = true,
	cmd = "Neogit",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"sindrets/diffview.nvim",
	},
	keys = {
		{ "<leader>ng", "<cmd>Neogit<cr>", desc = "Show Neogit UI" },
	},
}
