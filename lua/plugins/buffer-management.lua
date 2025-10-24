return {
	"j-morano/buffer_manager.nvim",
	event = "BufRead",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local map = vim.keymap.set

		map("n", "<C-space>", ":lua require('buffer_manager.ui').toggle_quick_menu()<CR>")
		map("n", "<C-h>", ":lua require('buffer_manager.ui').nav_next()<CR>")
		map("n", "<C-l>", ":lua require('buffer_manager.ui').nav_prev()<CR>")
	end,
}
