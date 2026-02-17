return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {},
	keys = {
		{ "<leader>ft", "<cmd>TodoQuickFix<cr>", desc = "Find TODOs" },
	},
}
