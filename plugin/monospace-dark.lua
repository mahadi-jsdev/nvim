-- Monospace Dark Color Scheme Plugin
-- This file ensures the color scheme is loaded when Neovim starts

-- Only load if not already loaded
if vim.g.colors_name == "monospace-dark" then
	return
end

-- Load the color scheme
vim.cmd("colorscheme monospace-dark")
