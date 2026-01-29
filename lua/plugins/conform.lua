return {
	"stevearc/conform.nvim",
	event = "LspAttach",
	config = function()
		local prettier_formatters = {
			"prettierd",
			"prettier",
			stop_after_first = true,
		}

		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = prettier_formatters,
				typescript = prettier_formatters,
				typescriptreact = prettier_formatters,
				html = prettier_formatters,
				css = prettier_formatters,
				json = prettier_formatters,
			},
			format_after_save = {
				lsp_format = "fallback",
			},
		})
	end,
}
