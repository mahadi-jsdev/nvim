return {
	"nvim-mini/mini.tabline",
	event = "BufRead",
	version = "*",
	config = function()
		require("mini.tabline").setup()
	end,
}
