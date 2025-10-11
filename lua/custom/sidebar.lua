local api = vim.api

local Sidebar = {}
Sidebar.win = nil
Sidebar.buf = nil

-- 🎨 Dracula-inspired colors
Sidebar.colors = {
	bg = "#282a36", -- background
	fg = "#f8f8f2", -- text
	active = "#bd93f9", -- active buffer
	accent = "#ffb86c", -- accent text
	border = "#44475a", -- border
}

-- Helper: get 2-level relative path
local function two_level_path(full_path)
	if full_path == "" then
		return "[No Name]"
	end
	local parts = vim.split(full_path, "/", { plain = true })
	local len = #parts
	if len >= 2 then
		return parts[len - 1] .. "/" .. parts[len]
	else
		return parts[len]
	end
end

-- Draw buffer list
function Sidebar.render()
	if not Sidebar.buf or not api.nvim_buf_is_valid(Sidebar.buf) then
		Sidebar.buf = api.nvim_create_buf(false, true)
		api.nvim_buf_set_option(Sidebar.buf, "bufhidden", "wipe")
	end

	local lines = {}
	local current = api.nvim_get_current_buf()
	local buffers = vim.fn.getbufinfo({ buflisted = 1 })

	for _, b in ipairs(buffers) do
		local display = two_level_path(b.name)
		if b.bufnr == current then
			table.insert(lines, " " .. display .. " *") -- highlight active buffer
		else
			table.insert(lines, " " .. display)
		end
	end

	api.nvim_buf_set_lines(Sidebar.buf, 0, -1, false, lines)

	-- Highlight active buffer
	api.nvim_buf_clear_namespace(Sidebar.buf, -1, 0, -1)
	for i, b in ipairs(buffers) do
		if b.bufnr == current then
			api.nvim_buf_add_highlight(Sidebar.buf, -1, "SidebarActive", i - 1, 0, -1)
		end
	end
end

-- Toggle sidebar window (floating)
function Sidebar.toggle()
	if Sidebar.win and api.nvim_win_is_valid(Sidebar.win) then
		api.nvim_win_close(Sidebar.win, true)
		Sidebar.win = nil
		return
	end

	Sidebar.render()

	local columns = vim.o.columns
	local width = 40
	Sidebar.win = api.nvim_open_win(Sidebar.buf, false, {
		relative = "editor",
		width = width,
		height = vim.o.lines - 2,
		row = 1,
		col = columns - width,
		style = "minimal",
		border = "single",
	})

	api.nvim_win_set_option(Sidebar.win, "winhl", "Normal:SidebarNormal,FloatBorder:SidebarBorder")
end

-- Auto-refresh when buffers change
vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete", "BufEnter" }, {
	callback = function()
		if Sidebar.win and api.nvim_win_is_valid(Sidebar.win) then
			Sidebar.render()
		end
	end,
})

-- Dracula highlights
vim.api.nvim_set_hl(0, "SidebarNormal", { bg = Sidebar.colors.bg, fg = Sidebar.colors.fg })
vim.api.nvim_set_hl(0, "SidebarActive", { bg = Sidebar.colors.bg, fg = Sidebar.colors.active, bold = true })
vim.api.nvim_set_hl(0, "SidebarBorder", { fg = Sidebar.colors.border })

-- Keymap to toggle sidebar
vim.keymap.set("n", "<leader>bs", Sidebar.toggle, { desc = "[B]uffer [S]idebar" })

return Sidebar
