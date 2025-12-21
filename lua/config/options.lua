local opt = vim.opt
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Settings
opt.clipboard = "unnamedplus"
opt.termguicolors = true
opt.winborder = "rounded"
opt.relativenumber = true
opt.number = true
opt.wrap = false
opt.fillchars = { eob = " " }
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.smartindent = true
opt.shiftround = true
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.incsearch = true
opt.undofile = true
opt.swapfile = false
opt.backup = false
opt.writebackup = false
opt.autoread = true
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldcolumn = "0"
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true

-- Optimized Fold Text
_G.custom_fold_text = function()
	local line = vim.fn.getline(vim.v.foldstart)
	local line_count = vim.v.foldend - vim.v.foldstart + 1
	return "  " .. line .. " ... " .. line_count .. " lines "
end
opt.foldtext = "v:lua.custom_fold_text()"
vim.g.loaded_netrwPlugin = 1

-- Diagnostics appearance
vim.diagnostic.config({
	virtual_text = true,
	signs = false,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		border = "rounded",
		source = "always",
	},
})
