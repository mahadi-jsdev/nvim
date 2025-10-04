return {
	"folke/todo-comments.nvim",
	event = "VeryLazy",
	opts = {},
	dependencies = { "nvim-lua/plenary.nvim", "folke/snacks.nvim" },
	keys = {
		{
			"<leader>tt",
			function()
				Snacks.picker.todo_comments()
			end,
			desc = "Todo",
		},
	},
}
