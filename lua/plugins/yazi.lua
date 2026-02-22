return {
	"mikavilpas/yazi.nvim",
	version = "*", -- use the latest stable version
	cmd = "Yazi",
	dependencies = {
		{ "nvim-lua/plenary.nvim", lazy = true },
	},
	keys = {
		{
			"-",
			mode = { "n", "v" },
			"<cmd>Yazi<cr>",
			desc = "Open yazi at the current file",
		},
	},
	opts = {
		open_for_directories = true,
	},
	init = function()
		-- Folders only function
		local function folders_only()
			local fd_cmd = "fdfind --type d --hidden --exclude .git"
			local fd_handle = io.popen(fd_cmd)
			local results = {}

			if fd_handle then
				for line in fd_handle:lines() do
					local abs_path = vim.fn.fnamemodify(line, ":p")
					local display = line
					table.insert(results, { path = abs_path, display = display })
				end
				fd_handle:close()
			end

			-- add project root (cwd) at the very top
			local cwd = vim.fn.getcwd()
			table.insert(results, 1, {
				path = cwd,
				display = "root",
			})

			vim.ui.select(results, {
				prompt = "Folders:",
				format_item = function(item)
					return item.display
				end,
			}, function(selected)
				if not selected then
					return
				end

				require("yazi").yazi({}, selected.path)
			end)
		end

		-- Set up key mapping for folders only
		vim.api.nvim_set_keymap("n", "<C-space>", "", {
			noremap = true,
			silent = true,
			desc = "Folders only (Yazi compatible)",
			callback = folders_only,
		})
	end,
}
