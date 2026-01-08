return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require("neo-tree").setup({
			close_if_last_window = true,
			source_selector = {
				winbar = false, -- Hide the top selector to keep it clean
			},
			buffers = {
				follow_current_file = { enabled = true }, -- Highlight active buffer
				group_empty_dirs = true,
				show_unnamed = false, -- FILTER: Hide unnamed buffers
				use_libuv_file_watcher = true, -- Auto-updates when files change
			},
			window = {
				width = 35,
			},
		})

		vim.keymap.set("n", "<leader>e", "<CMD>Neotree filesystem reveal toggle<CR>", { desc = "Buffer List Sidebar" })
		vim.keymap.set("n", "<C-b>", "<CMD>Neotree buffers right reveal<CR>", { desc = "Buffer List Sidebar" })
	end,
}
