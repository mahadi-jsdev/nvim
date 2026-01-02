return {
	"windwp/windline.nvim",
	event = "BufRead",
	config = function()
		require("wlsample.vscode")
	end,
}
