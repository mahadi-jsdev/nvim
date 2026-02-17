return {
	"akinsho/toggleterm.nvim",
	keys = {
		{
			"<C-`>",
			"<cmd>ToggleTerm<cr>",
			desc = "Toggle Terminal",
		},
	},
	config = function()
		require("toggleterm").setup({
			size = 20,
			open_mapping = [[<C-`>]],
			shade_filetypes = {},
			shade_terminals = true,
			shading_factor = 2,
			start_in_insert = true,
			insert_mappings = true,
			persist_size = true,
			direction = "horizontal",
			close_on_exit = true,
			shell = vim.o.shell,
		})
	end,
}
