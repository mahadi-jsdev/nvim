-- Autocmds (highlight yanks)
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 150,
		})
	end,
})

-- Create an augroup for LSP progress
local progress_group = vim.api.nvim_create_augroup("LspProgressNotify", { clear = true })

vim.api.nvim_create_autocmd("LspProgress", {
	group = progress_group,
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		local value = ev.data.params.value -- Progress data

		if not client or type(value) ~= "table" then
			return
		end

		local name = client.name
		local msg = ""

		if value.kind == "begin" then
			msg = "0%"
		elseif value.kind == "report" then
			-- Handle percentage if provided by the server
			msg = (value.percentage and (value.percentage .. "%%") or "Loading...")
		elseif value.kind == "end" then
			msg = "100% - Completed"
		end

		-- Display the message in the command line or via your notification plugin
		if msg ~= "" then
			vim.notify(name .. ": " .. (value.title or "") .. " " .. msg, vim.log.levels.INFO, {
				id = "lsp_progress", -- This ID prevents notification spam by overwriting the same notification
				title = "LSP Progress",
			})
		end
	end,
})
