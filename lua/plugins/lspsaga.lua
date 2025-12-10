return {
	"nvimdev/lspsaga.nvim",
	event = "VeryLazy",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("lspsaga").setup({
			lightbulb = {
				enable = false,
			},
			symbol_in_winbar = {
				folder_level = 2,
			},
		})
	end,
}
