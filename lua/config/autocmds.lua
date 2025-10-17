-- Autocmds (highlight yanks)
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ higroup = "SnacksPickerSelected", timeout = 200 })
	end,
})
