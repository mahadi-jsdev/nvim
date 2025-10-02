return {
	"saghen/blink.cmp",
	event = "LspAttach",
	version = "1.*",
	dependencies = {
		{
			"mikavilpas/blink-ripgrep.nvim",
			version = "*",
		},
	},
	config = function()
		require("blink.cmp").setup({
			keymap = {
				preset = "none",
				["<CR>"] = { "accept", "fallback" },
				["<Tab>"] = { "accept", "fallback" },
				["<C-j>"] = { "select_next", "fallback" },
				["<C-k>"] = { "select_prev", "fallback" },
				["<Down>"] = { "select_next", "fallback" },
				["<Up>"] = { "select_prev", "fallback" },
				["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
			},
			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "mono",
			},
			sources = {
				default = {
					"lsp",
					"buffer",
					"path",
					"snippets",
					"ripgrep",
				},
				providers = {
					ripgrep = {
						module = "blink-ripgrep",
						name = "Ripgrep",
						opts = {
							prefix_min_len = 3,
							project_root_marker = ".git",
							fallback_to_regex_highlighting = true,
							toggles = {
								on_off = nil,
								debug = nil,
							},
							backend = {
								use = "gitgrep-or-ripgrep",
								customize_icon_highlight = true,
								ripgrep = {
									context_size = 5,
									max_filesize = "1M",
									project_root_fallback = true,
									search_casing = "--ignore-case",
									additional_rg_options = {},
									ignore_paths = {},
									additional_paths = {},
								},
							},
							gitgrep = {},
							debug = false,
						},
						transform_items = function(_, items)
							for _, item in ipairs(items) do
								item.labelDetails = {
									description = "(rg)",
								}
							end
							return items
						end,
					},
				},
			},
			completion = {
				accept = { auto_brackets = { enabled = false } },
				menu = {
					draw = {
						columns = {
							{ "kind_icon", "label", "label_description", gap = 1 },
						},
						treesitter = { "lsp" },
						components = {
							label = {
								text = function(ctx)
									return ctx.item.label
								end,
								highlight = function(ctx)
									return ctx.highlights
								end,
							},
						},
					},
				},
				documentation = { auto_show = true, auto_show_delay_ms = 500 },
			},
		})
	end,
}
