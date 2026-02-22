return {
	"kevinhwang91/nvim-ufo",
	dependencies = "kevinhwang91/promise-async",
	opts = {},
	init = function()
		vim.opt.foldlevel = 99
		vim.opt.foldlevelstart = 99

		require("ufo").setup({
			provider_selector = function()
				return { "treesitter", "indent" }
			end,
		})
	end,
}
