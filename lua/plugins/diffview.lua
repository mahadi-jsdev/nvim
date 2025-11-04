return {
	"sindrets/diffview.nvim",
	event = "VeryLazy",
	config = function()
		local map = vim.keymap.set

		map("n", "<leader>do", "<CMD>DiffviewOpen<CR>")
		map("n", "<leader>dc", "<CMD>DiffviewClose<CR>")
		map("n", "<leader>df", "<CMD>DiffviewFileHistory %<CR>")
	end,
}
