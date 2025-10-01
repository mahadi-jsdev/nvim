local blink = require("blink.cmp")
local capabilities = blink.get_lsp_capabilities() or {}

local on_attach = function(_, bufnr)
	local map = vim.keymap.set
	local opts = { noremap = true, silent = true, buffer = bufnr }

	-- LSP keymaps
	map("n", "<leader>lr", vim.lsp.buf.rename, opts)
	map("n", "<leader>la", vim.lsp.buf.code_action, opts)
	map("n", "<leader>ld", vim.diagnostic.open_float, opts)
	map("n", "K", vim.lsp.buf.hover, opts)
	map("n", "gd", function()
		Snacks.picker.lsp_definitions()
	end, opts)
	map("n", "gr", function()
		Snacks.picker.lsp_references()
	end, opts)
	map("n", "gs", function()
		Snacks.picker.lsp_symbols()
	end)
	map("n", "<leader>ll", function()
		Snacks.picker.diagnostics()
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
}

capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}

-- Server setup
for _, lsp in ipairs(servers) do
	vim.lsp.config(lsp, {
		on_attach = on_attach,
		capabilities = capabilities,
	})
end
