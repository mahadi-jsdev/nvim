return {
	"sainnhe/gruvbox-material",
	priority = 1000,
	lazy = false,
	config = function()
		vim.g.gruvbox_material_background = "hard" -- "hard", "medium" (default), "soft"
		vim.g.gruvbox_material_foreground = "material" -- "original", "mix", "material"
		vim.cmd("colorscheme gruvbox-material")
	end,
}
