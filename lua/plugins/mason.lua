return {
	"mason-org/mason-lspconfig.nvim",
	opts = {},
	event = "BufReadPre",
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} },
		"neovim/nvim-lspconfig",
	},
	config = function()
		require("mason").setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				"ts_ls",
				"eslint",
				"tailwindcss",
				"html",
				"cssls",
			},
		})
	end,
}
