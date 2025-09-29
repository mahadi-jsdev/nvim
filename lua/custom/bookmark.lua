-- plugin/project_bookmarks.lua
local M = {}

local bookmarks = {}

-- Get project identifier (git repo or current directory)
local function get_project_id()
	local git_dir = vim.fn.finddir(".git", ".;")
	if git_dir ~= "" then
		return vim.fn.fnamemodify(git_dir, ":p:h:h")
	else
		return vim.fn.getcwd()
	end
end

-- Initialize bookmarks table for current project
local function init_project_bookmarks()
	local project_id = get_project_id()
	if not bookmarks[project_id] then
		bookmarks[project_id] = {}
	end
	return bookmarks[project_id]
end

-- Get current project bookmarks
local function get_current_bookmarks()
	local project_id = get_project_id()
	return bookmarks[project_id] or {}
end

-- Set current project bookmarks
local function set_current_bookmarks(new_bookmarks)
	local project_id = get_project_id()
	bookmarks[project_id] = new_bookmarks or {}
end

-- Get relative path from project root
local function get_relative_path(path)
	local root = get_project_id()
	local abs_path = vim.fn.fnamemodify(path, ":p")
	return abs_path:sub(#root + 2)
end

-- Get absolute path from relative path
local function get_absolute_path(rel_path)
	local root = get_project_id()
	return root .. "/" .. rel_path
end

-- Add file to bookmarks
function M.add_bookmark(path)
	path = path or vim.fn.expand("%:p")
	if path == "" then
		vim.notify("No file to bookmark", vim.log.levels.WARN)
		return
	end

	local current_bookmarks = get_current_bookmarks()
	local rel_path = get_relative_path(path)
	local name = vim.fn.fnamemodify(path, ":t")

	if not current_bookmarks[rel_path] then
		current_bookmarks[rel_path] = name
		set_current_bookmarks(current_bookmarks)
		vim.notify("Bookmarked: " .. name, vim.log.levels.INFO)
		return true
	else
		vim.notify("Already bookmarked: " .. name, vim.log.levels.WARN)
		return false
	end
end

-- Remove a bookmark
function M.remove_bookmark(rel_path)
	local current_bookmarks = get_current_bookmarks()
	if current_bookmarks[rel_path] then
		local name = current_bookmarks[rel_path]
		current_bookmarks[rel_path] = nil
		set_current_bookmarks(current_bookmarks)
		vim.notify("Removed bookmark: " .. name, vim.log.levels.INFO)
		return true
	end
	return false
end

-- Toggle bookmark for current file
function M.toggle_bookmark(path)
	path = path or vim.fn.expand("%:p")
	if path == "" then
		vim.notify("No file to toggle bookmark", vim.log.levels.WARN)
		return
	end

	local current_bookmarks = get_current_bookmarks()
	local rel_path = get_relative_path(path)
	local name = vim.fn.fnamemodify(path, ":t")

	if current_bookmarks[rel_path] then
		-- Remove bookmark
		current_bookmarks[rel_path] = nil
		set_current_bookmarks(current_bookmarks)
		vim.notify("Bookmark removed: " .. name, vim.log.levels.INFO)
	else
		-- Add bookmark
		current_bookmarks[rel_path] = name
		set_current_bookmarks(current_bookmarks)
		vim.notify("Bookmarked: " .. name, vim.log.levels.INFO)
	end
end

-- Add multiple files to bookmarks
function M.add_multiple_bookmarks(paths)
	if not paths or #paths == 0 then
		vim.notify("No files to bookmark", vim.log.levels.WARN)
		return
	end

	local current_bookmarks = get_current_bookmarks()
	local count = 0

	for _, path in ipairs(paths) do
		local rel_path = get_relative_path(path)
		local name = vim.fn.fnamemodify(path, ":t")

		if not current_bookmarks[rel_path] then
			current_bookmarks[rel_path] = name
			count = count + 1
		end
	end

	set_current_bookmarks(current_bookmarks)
	vim.notify("Bookmarked " .. count .. " file(s)", vim.log.levels.INFO)
end

-- Open bookmarked files
function M.open_bookmark()
	local current_bookmarks = get_current_bookmarks()
	if vim.tbl_isempty(current_bookmarks) then
		vim.notify("No bookmarks found", vim.log.levels.WARN)
		return
	end

	local opts = {}
	local paths = {}
	for rel_path, name in pairs(current_bookmarks) do
		local display = name .. " (" .. rel_path .. ")"
		table.insert(opts, display)
		paths[display] = rel_path
	end

	table.sort(opts)

	vim.ui.select(opts, {
		prompt = "Select Bookmark:",
	}, function(choice)
		if choice and paths[choice] then
			local abs_path = get_absolute_path(paths[choice])
			if vim.fn.filereadable(abs_path) == 1 then
				vim.cmd("edit " .. vim.fn.fnameescape(abs_path))
			else
				vim.notify("File not found: " .. abs_path, vim.log.levels.ERROR)
				M.remove_bookmark(paths[choice])
			end
		end
	end)
end

-- List all bookmarks with removal capability
function M.list_bookmarks()
	local current_bookmarks = get_current_bookmarks()
	if vim.tbl_isempty(current_bookmarks) then
		vim.notify("No bookmarks found", vim.log.levels.WARN)
		return
	end

	local lines = { "# Project Bookmarks (Press dd to remove, Enter to open, q to quit):" }
	local line_map = {} -- Maps line numbers to relative paths

	for rel_path, name in pairs(current_bookmarks) do
		local line = name .. " | " .. rel_path
		table.insert(lines, line)
		line_map[#lines] = rel_path
	end

	table.sort(lines, function(a, b)
		if a:sub(1, 1) == "#" then
			return true
		end
		if b:sub(1, 1) == "#" then
			return false
		end
		return a:lower() < b:lower()
	end)

	-- Rebuild line_map after sorting
	line_map = {}
	for i, line in ipairs(lines) do
		if line:sub(1, 1) ~= "#" then
			local rel_path = line:match("| (.+)$")
			if rel_path then
				line_map[i] = rel_path
			end
		end
	end

	vim.cmd("enew")
	local buf = vim.api.nvim_get_current_buf()
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
	vim.api.nvim_buf_set_option(buf, "buftype", "nofile")
	vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
	vim.api.nvim_buf_set_option(buf, "modifiable", false)
	vim.api.nvim_buf_set_option(buf, "buflisted", false)
	vim.api.nvim_buf_set_option(buf, "filetype", "project_bookmarks")

	-- Key mappings
	vim.api.nvim_buf_set_keymap(buf, "n", "q", ":bd<CR>", { noremap = true, silent = true })

	-- Function to open selected bookmark
	_G.open_selected_bookmark = function()
		local line_nr = vim.api.nvim_win_get_cursor(0)[1]
		local rel_path = line_map[line_nr]
		if rel_path then
			local abs_path = get_absolute_path(rel_path)
			if vim.fn.filereadable(abs_path) == 1 then
				vim.cmd("bd")
				vim.cmd("edit " .. vim.fn.fnameescape(abs_path))
			else
				vim.notify("File not found: " .. abs_path, vim.log.levels.ERROR)
				M.remove_bookmark(rel_path)
				M.list_bookmarks() -- Refresh the list
			end
		end
	end

	-- Function to remove bookmark
	_G.remove_selected_bookmark = function()
		local line_nr = vim.api.nvim_win_get_cursor(0)[1]
		local rel_path = line_map[line_nr]
		if rel_path then
			local name = get_current_bookmarks()[rel_path] or rel_path
			M.remove_bookmark(rel_path)
			vim.notify("Removed bookmark: " .. name, vim.log.levels.INFO)
			M.list_bookmarks() -- Refresh the list
		end
	end

	vim.api.nvim_buf_set_keymap(
		buf,
		"n",
		"<CR>",
		":lua open_selected_bookmark()<CR>",
		{ noremap = true, silent = true }
	)
	vim.api.nvim_buf_set_keymap(
		buf,
		"n",
		"dd",
		":lua remove_selected_bookmark()<CR>",
		{ noremap = true, silent = true }
	)

	vim.api.nvim_win_set_option(0, "winfixheight", true)
	vim.api.nvim_win_set_option(0, "winfixwidth", true)
end

-- Setup function
function M.setup()
	-- Initialize bookmarks for current project
	init_project_bookmarks()

	-- Create commands
	vim.api.nvim_create_user_command("ProjectBookmarkAdd", function()
		M.add_bookmark()
	end, {})

	vim.api.nvim_create_user_command("ProjectBookmarkOpen", function()
		M.open_bookmark()
	end, {})

	local map = vim.keymap.set

	map("n", "<C-l>", "<CMD>ProjectBookmarkOpen<CR>", {
		noremap = true,
		silent = true,
		desc = "Open bookmarks",
	})

	-- Toggle bookmark for current file
	map("n", "<C-n>", function()
		M.toggle_bookmark()
	end, {
		noremap = true,
		silent = true,
		desc = "Toggle bookmark for current file",
	})
end

return M
