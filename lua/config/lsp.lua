local blink = require("blink.cmp")
local telescope = require("telescope.builtin")
local capabilities =  blink.get_lsp_capabilities() or {}

	local on_attach = function(_, bufnr)
    local map = vim.keymap.set
		local opts = { noremap = true, silent = true, buffer = bufnr }

		-- LSP keymaps
		map("n", "<leader>lr", vim.lsp.buf.rename, opts)
		map("n", "<leader>la", vim.lsp.buf.code_action, opts)
		map("n", "<leader>ld", vim.diagnostic.open_float, opts)
		map("n", "K", vim.lsp.buf.hover, opts)
		map("n", "gd", telescope.lsp_definitions, opts)
		map("n", "gr", telescope.lsp_references, opts)
		map("n", "gs", telescope.lsp_document_symbols)
		map("n", "<leader>ll", function()
			telescope.diagnostics({ bnfnr = 0 })
		end, opts)
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
		"bashls",
		"svelte",
	}

	-- Server setup
	for _, lsp in ipairs(servers) do
		vim.lsp.config(lsp, {
			on_attach = on_attach,
			capabilities = capabilities,
		})
	end
