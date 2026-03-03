return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"onsails/lspkind-nvim",
	},
	config = function()
		local cmp_ok, cmp = pcall(require, "cmp")
		if not cmp_ok then
			return
		end
		local lspkind_ok, lspkind = pcall(require, "lspkind")
		cmp.setup({
			-- snippets disabled (no-op expand required by nvim-cmp)
			snippet = { expand = function(_) end },
			mapping = {
				["<CR>"] = cmp.mapping.confirm({ select = true }),
				["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
				["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
				["<Down>"] = cmp.mapping.select_next_item(),
				["<Up>"] = cmp.mapping.select_prev_item(),
				["<C-Space>"] = cmp.mapping.complete(),
			},
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "buffer" },
				{ name = "path" },
			}),
			formatting = {
				format = function(entry, vim_item)
					-- Use lspkind when available for nice icons + text
					if lspkind_ok and lspkind.cmp_format then
						return lspkind.cmp_format({ mode = "symbol_text", maxwidth = 50, ellipsis_char = "..." })(
							entry,
							vim_item
						)
					end
					-- Fallback: append source name to the menu
					vim_item.menu = ({
						buffer = "[Buffer]",
						nvim_lsp = "[LSP]",
						path = "[Path]",
					})[entry.source.name]
					return vim_item
				end,
			},
			experimental = { ghost_text = false },
			completion = { completeopt = "menu,menuone,noinsert" },
			window = {
				completion = {
					max_height = 10,
				},
			},
		})
	end,
}
