return {
	"nvim-lualine/lualine.nvim",
	event = "BufRead",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({
			options = {
				theme = "auto",
				component_separators = { left = "│", right = "│" },
				section_separators = { left = "", right = "" },
				globalstatus = true,
				disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
			},
			sections = {
				lualine_a = {
					{ "mode", separator = { left = "" }, right_padding = 2 },
				},
				lualine_b = {
					"branch",
				},
				lualine_c = {
					{
						"filename",
						path = 3,
						fmt = function(str)
							-- Get file icon and color
							local devicons = require("nvim-web-devicons")
							local filename = vim.fn.fnamemodify(str, ":t")
							local ext = vim.fn.fnamemodify(str, ":e")
							local icon, iconhl = devicons.get_icon(filename, ext, { default = true })

							-- Split path
							local parts = {}
							for part in string.gmatch(str, "[^/]+") do
								table.insert(parts, part)
							end
							local n = #parts

							-- Shorten path with ellipsis if long
							local display_path
							if n > 3 then
								display_path = parts[n - 1] .. "/" .. parts[n]
							elseif n == 3 then
								display_path = "/" .. parts[n - 2] .. "/" .. parts[n - 1] .. "/" .. parts[n]
							elseif n == 2 then
								display_path = "/" .. parts[n - 1] .. "/" .. parts[n]
							else
								display_path = str
							end

							-- Add icon and highlight
							local icon_str = icon and ("%#" .. iconhl .. "#" .. icon .. "%* ") or ""
							return string.format("%s%s", icon_str, display_path)
						end,
						padding = { left = 1, right = 1 },
					},
					"diagnostics",
				},
				lualine_x = {
					{ "diff", symbols = { added = " ", modified = " ", removed = " " } },
				},
				lualine_y = {
					"filetype",
				},
				lualine_z = {
					{ "location" },
					{ "progress", separator = { right = "" }, left_padding = 2 },
				},
			},
		})
	end,
}
