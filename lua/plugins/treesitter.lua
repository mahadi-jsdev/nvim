return {
	"nvim-treesitter/nvim-treesitter",
	event = "BufRead",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"lua",
				"vim",
				"vimdoc",
				"query",
				"javascript",
				"typescript",
				"tsx",
				"html",
				"css",
				"json",
				"yaml",
				"markdown",
				"bash",
				"python",
				"rust",
				"go",
				"java",
				"cpp",
				"c",
			},
			highlight = {
				enable = true,
			},
			auto_install = true,
			indent = {
				enable = true,
			},
		})
	end,
}
