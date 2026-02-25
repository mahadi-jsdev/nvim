return {
	"nvim-mini/mini.tabline",
	version = "*",
	config = function()
		require("mini.tabline").setup({
			show_icons = true,
		})
	end,
}
