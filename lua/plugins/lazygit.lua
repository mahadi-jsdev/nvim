return {
	"kdheepak/lazygit.nvim",
	event = "VeryLazy",
	cmd = { "LazyGit" },
	config = function()
		vim.keymap.set("n", "<leader>gg", "<CMD>LazyGit<CR>", { desc = "LazyGit" })
	end,
}
