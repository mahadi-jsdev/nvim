return {
	"dracula/vim",
	lazy = false, -- Load immediately
	priority = 1000, -- Load before other plugins
	config = function()
		vim.g.dracula_italic = 0
		vim.opt.background = "dark"
		vim.cmd("silent! colorscheme dracula")
	end,
}
