return {
	"nvim-mini/mini.icons",
	event = "VeryLazy",
	version = false,
	config = function()
		require("mini.icons").setup()
	end,
}
