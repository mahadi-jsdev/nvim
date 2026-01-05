return {
	"ojroques/nvim-bufdel",
	config = function()
		require("bufdel").setup({
			quit = false,
		})

		vim.keymap.set("n", "<C-x>", "<CMD>BufDel<CR>")
	end,
}
