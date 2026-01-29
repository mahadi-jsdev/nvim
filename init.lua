if vim.g.vscode then
	vim.opt.clipboard = "unnamedplus"
else
	require("config.options")
	require("config.keymaps")
	require("config.autocmds")
	require("config.lazy")
end
