return {
	"chrisgrieser/nvim-origami",
	event = "BufRead",
	config = function()
		require("origami").setup({
			useLspFoldsWithTreesitterFallback = true,
			pauseFoldsOnSearch = true,
			foldtext = {
				enabled = true,
				padding = 3,
				lineCount = {
					template = "%d lines", -- `%d` is replaced with the number of folded lines
					hlgroup = "Comment",
				},
				diagnosticsCount = true, -- uses hlgroups and icons from `vim.diagnostic.config().signs`
				gitsignsCount = true, -- requires `gitsigns.nvim`
			},
			autoFold = {
				enabled = false,
			},
			foldKeymaps = {
				setup = false,
				hOnlyOpensOnFirstColumn = false,
			},
		})

		vim.keymap.set("n", "zz", "za", {
			noremap = false,
			silent = true,
			desc = "Center screen and toggle fold",
		})
	end,
}
