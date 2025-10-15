return {
	"danymat/neogen",
	event = "BufRead",
	config = function()
		require("neogen").setup({})

		-- keymaps
		local opts = { noremap = true, silent = true }
		vim.api.nvim_set_keymap("n", "<Leader>ng", ":lua require('neogen').generate()<CR>", opts)
	end,
}
