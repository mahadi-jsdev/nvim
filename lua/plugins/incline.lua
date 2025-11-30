return {
	"b0o/incline.nvim",
	event = "BufRead",
	config = function()
		local helpers = require("incline.helpers")
		local devicons = require("nvim-web-devicons")
		require("incline").setup({
			window = {
				padding = 0,
				margin = { horizontal = 0 },
			},
			render = function(props)
				local filepath = vim.api.nvim_buf_get_name(props.buf)
				local filename = vim.fn.fnamemodify(filepath, ":t")
				local folder = vim.fn.fnamemodify(filepath, ":h:t")
				if filename == "" then
					filename = "[No Name]"
					folder = ""
				end

				local function get_diagnostic_label()
					local icons = { error = " ", warn = " ", info = " ", hint = " " }
					local label = {}

					for severity, icon in pairs(icons) do
						local n = #vim.diagnostic.get(
							props.buf,
							{ severity = vim.diagnostic.severity[string.upper(severity)] }
						)
						if n > 0 then
							table.insert(label, { " " .. icon .. n, group = "DiagnosticSign" .. severity }) -- Added space before icon
						end
					end
					if #label > 0 then
						table.insert(label, { " " })
					end
					return label
				end

				local display_name = folder ~= "" and folder .. "/" .. filename or filename
				local ft_icon, ft_color = devicons.get_icon_color(filename)
				local modified = vim.bo[props.buf].modified
				return {
					{ get_diagnostic_label() },
					ft_icon and { " ", ft_icon, " ", guibg = ft_color, guifg = helpers.contrast_color(ft_color) } or "",
					" ",
					{ display_name, gui = modified and "bold,italic" or "bold" },
					" ",
					guibg = "#44406e",
				}
			end,
		})
	end,
}
