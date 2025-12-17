return {
	"kdheepak/lazygit.nvim",
	event = "VeryLazy",
	cmd = { "LazyGit" },
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		vim.keymap.set("n", "<leader>gg", ":LazyGit<CR>", { desc = "LazyGit" })
	end,
}
