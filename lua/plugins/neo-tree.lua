return {
	"nvim-neo-tree/neo-tree.nvim",
	event = "VeryLazy",
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
				window = {
					mappings = {
						["bd"] = "buffer_delete", -- Press 'bd' to close a buffer
					},
				},
			},
			window = {
				position = "right", -- SIDEBAR: Open on the right
				width = 30,
			},
		})

		vim.keymap.set("n", "<C-a>", "<CMD>Neotree  buffers<CR>", { desc = "Buffer List Sidebar" })
	end,
}
