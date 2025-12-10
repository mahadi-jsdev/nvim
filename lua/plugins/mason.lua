return {
	{
		"williamboman/mason.nvim",
		cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonLog" },
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		event = "VeryLazy",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"cssls", -- css-lsp
					"eslint", -- eslint-lsp
					"html", -- html-lsp
					"lua_ls", -- lua-language-server
					"tailwindcss", -- tailwindcss-language-server
					"ts_ls", -- typescript-language-server,
				},
				automatic_installation = true,
			})
		end,
	},
}
