return {
	"NeogitOrg/neogit",
	lazy = true,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"sindrets/diffview.nvim",
		"ibhagwan/fzf-lua",
	},
	cmd = "Neogit",
	keys = {
		{ "<leader>ng", "<cmd>Neogit<cr>", desc = "Show Neogit UI" },
	},
}
