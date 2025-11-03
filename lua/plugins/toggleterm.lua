return {
	"akinsho/toggleterm.nvim",
	event = "VeryLazy",
	version = "*",
	config = function()
		require("toggleterm").setup({
			open_mapping = [[<C-`>]],
			direction = "float",
		})
	end,
}
