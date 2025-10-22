return {
	"gbprod/yanky.nvim",
	event = "BufRead",
	opts = {},
	dependencies = { "folke/snacks.nvim" },
	keys = {
		{
			"<C-p>",
			function()
				Snacks.picker.yanky()
			end,
			mode = { "n", "x" },
			desc = "Open Yank History",
		},
	},
}
