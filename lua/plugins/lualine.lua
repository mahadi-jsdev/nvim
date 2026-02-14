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
					"diagnostics",
				},
				lualine_x = {
					"copilot",
					{ "diff", symbols = { added = " ", modified = " ", removed = " " } },
				},
				lualine_y = {
					{
						function()
							return "󰓩 " .. #vim.fn.getbufinfo({ buflisted = 1 })
						end,
						color = { fg = "#7aa2f7", gui = "bold" },
					},
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
