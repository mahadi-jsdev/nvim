return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"saghen/blink.cmp",
		"ibhagwan/fzf-lua",
	},
	config = function()
		local fzf = require("fzf-lua")
		local blink = require("blink.cmp")
		local capabilities = blink.get_lsp_capabilities() or {}

		local on_attach = function(_, bufnr)
			local map = vim.keymap.set
			local opts = { noremap = true, silent = true, buffer = bufnr }

			-- Standard Buffer Actions (Keep these as is)
			map("n", "<leader>lr", vim.lsp.buf.rename, opts)
			map("n", "<leader>ld", vim.diagnostic.open_float, opts)
			map("n", "K", vim.lsp.buf.hover, opts)

			-- LSP keymaps
			map("n", "<leader>ff", function()
				vim.lsp.buf.code_action({
					apply = true,
					context = {
						only = { "source.organizeImports" },
						diagnostics = {},
					},
				})
			end, opts)

			-- Fzf-lua Replacements
			map("n", "<leader>la", fzf.lsp_code_actions, opts) -- Searchable code actions
			map("n", "gd", fzf.lsp_definitions, opts)
			map("n", "gr", fzf.lsp_references, opts)
			map("n", "gs", fzf.lsp_document_symbols, opts)
			map("n", "gi", fzf.lsp_implementations, opts) -- NEW: Search implementations
			map("n", "<leader>fd", fzf.diagnostics_workspace, opts)

			-- Diagnostics navigation
			map("n", "[d", vim.diagnostic.goto_prev, opts)
			map("n", "]d", vim.diagnostic.goto_next, opts)
		end

		-- List of servers
		local servers = {
			"lua_ls",
			"ts_ls",
			"eslint",
			"tailwindcss",
			"html",
			"cssls",
		}

		-- Server setup
		for _, lsp in ipairs(servers) do
			vim.lsp.config(lsp, {
				on_attach = on_attach,
				capabilities = capabilities,
			})

			vim.lsp.enable(lsp)
		end
	end,
}
