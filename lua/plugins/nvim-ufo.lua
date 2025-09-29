return {
	"kevinhwang91/nvim-ufo",
	event = "BufRead",
	dependencies = "kevinhwang91/promise-async",
	config = function()
		require("ufo").setup()

		-- UFO-specific highlights (Dracula colors)
		vim.cmd([[
      hi UfoFoldedFg guifg=#6272a4 guibg=NONE
      hi UfoFoldedBg guifg=NONE guibg=#44475a
      highlight Folded ctermfg=61 ctermbg=237
      highlight Folded guifg=#6272a4 guibg=#44475a
    ]])
	end,
}
