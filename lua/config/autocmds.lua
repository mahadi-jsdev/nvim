-- Autocmds (highlight yanks)
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch", -- Uses the search highlight (orange/yellow)
			timeout = 150,
		})
	end,
})
