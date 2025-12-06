return {
	"NeogitOrg/neogit",
	lazy = true,
	cmd = "Neogit",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	keys = {
		{ "<leader>ng", "<cmd>Neogit<cr>", desc = "Show Neogit UI" },
	},
}
