local M = {}

local function map(lhs, rhs, opts)
	vim.keymap.set("i", lhs, rhs, opts or { noremap = true, silent = true })
end

local pairs_map = {
	["("] = ")",
	["["] = "]",
	["{"] = "}",
	["'"] = "'",
	['"'] = '"',
	["`"] = "`",
}

function M.setup()
	for open, close in pairs(pairs_map) do
		if open == close then
			-- Logic for same-character pairs (quotes)
			map(open, function()
				local col = vim.api.nvim_win_get_cursor(0)[2]
				local line = vim.api.nvim_get_current_line()
				local next_char = line:sub(col + 1, col + 1)

				if next_char == close then
					return "<Right>"
				else
					return open .. close .. "<Left>"
				end
			end, { expr = true, replace_keycodes = true })
		else
			-- Logic for different-character pairs (brackets)
			map(open, open .. close .. "<Left>")
			map(close, function()
				local col = vim.api.nvim_win_get_cursor(0)[2]
				local line = vim.api.nvim_get_current_line()
				local next_char = line:sub(col + 1, col + 1)

				if next_char == close then
					return "<Right>"
				else
					return close
				end
			end, { expr = true, replace_keycodes = true })
		end
	end

	-- Special case for Enter inside pairs
	map("<CR>", function()
		local col = vim.api.nvim_win_get_cursor(0)[2]
		local line = vim.api.nvim_get_current_line()
		local before = line:sub(col, col)
		local after = line:sub(col + 1, col + 1)

		for open, close in pairs(pairs_map) do
			if before == open and after == close then
				return "<CR><ESC>O"
			end
		end
		return "<CR>"
	end, { expr = true, replace_keycodes = true })

	-- Special case for Backspace
	map("<BS>", function()
		local col = vim.api.nvim_win_get_cursor(0)[2]
		local line = vim.api.nvim_get_current_line()
		local before = line:sub(col, col)
		local after = line:sub(col + 1, col + 1)

		for open, close in pairs(pairs_map) do
			if before == open and after == close then
				return "<BS><Del>"
			end
		end
		return "<BS>"
	end, { expr = true, replace_keycodes = true })
end

M.setup()

return M
