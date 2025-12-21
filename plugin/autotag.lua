local function close_tag()
	local line = vim.api.nvim_get_current_line()
	local col = vim.api.nvim_win_get_cursor(0)[2]
	local before = line:sub(1, col)

	-- Basic regex to find the last unclosed tag in the current line
	-- This handles simple cases like <div> without needing complex TS tree walking
	local tag = before:match("<([%w%-]+)$") or before:match("<([%w%-]+)%s+[^>]*$")

	if tag then
		return "></" .. tag .. ">" .. string.rep("<Left>", #tag + 3)
	end
	return ">"
end

local supported_fts = {
	"html",
	"javascriptreact",
	"typescriptreact",
	"svelte",
	"vue",
	"xml",
}

vim.api.nvim_create_autocmd("FileType", {
	pattern = supported_fts,
	callback = function()
		vim.keymap.set("i", ">", close_tag, { buffer = true, expr = true })
	end,
})
