return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	lazy = false,
	config = function()
		vim.keymap.set("n", "<leader>e", "<Cmd>Neotree toggle source=filesystem reveal=true position=left<CR>")
		vim.keymap.set("n", "<C-space>", "<Cmd>Neotree source=buffers reveal=true position=left<CR>")
		vim.keymap.set("n", "<C-g>", "<Cmd>Neotree source=git_status reveal=true position=left<CR>")

		require("neo-tree").setup({
			close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
			popup_border_style = "rounded", -- "double", "none", "rounded", "shadow", "single" or "solid"
			default_component_configs = {
				name = {
					trailing_slash = false,
					use_git_status_colors = true,
					highlight = "NeoTreeFileName",
				},
			},
			filesystem = {
				filtered_items = {
					visible = false, -- when true, they will just be displayed differently than normal items
					hide_dotfiles = true,
					hide_gitignored = true,
					hide_ignored = true, -- hide files that are ignored by other gitignore-like files
					-- other gitignore-like files, in descending order of precedence.
					ignore_files = {
						".neotreeignore",
						".ignore",
						-- ".rgignore"
					},
					hide_hidden = true, -- only works on Windows for hidden files/directories
					hide_by_name = {
						"node_modules",
					},
					hide_by_pattern = { -- uses glob style patterns
						--"*.meta",
						--"*/src/*/tsconfig.json",
					},
					always_show = { -- remains visible even if other settings would normally hide it
						--".gitignored",
					},
					always_show_by_pattern = { -- uses glob style patterns
						".env*",
					},
					never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
						--".DS_Store",
						--"thumbs.db"
					},
					never_show_by_pattern = { -- uses glob style patterns
						--".null-ls_*",
					},
				},
				follow_current_file = {
					enabled = true, -- This will find and focus the file in the active buffer every time
					--               -- the current file is changed while the tree is open.
					leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
				},
				group_empty_dirs = false, -- when true, empty folders will be grouped together
				hijack_netrw_behavior = "disabled", -- netrw disabled, opening a directory opens neo-tree
				-- in whatever position is specified in window.position
				-- "open_current",  -- netrw disabled, opening a directory opens within the
				-- window like netrw would, regardless of window.position
				-- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
				use_libuv_file_watcher = true, -- This will use the OS level file watchers to detect changes
				-- instead of relying on nvim autocmd events.
			},
			buffers = {
				follow_current_file = {
					enabled = true, -- This will find and focus the file in the active buffer every time
					--              -- the current file is changed while the tree is open.
					leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
				},
				group_empty_dirs = true, -- when true, empty folders will be grouped together
				show_unloaded = true,
			},
		})

		-- Custom NeoTree highlight colors
		-- Customize these colors to match your theme
		vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "#1e1e2e", fg = "#cdd6f4" })
		vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "#1e1e2e", fg = "#cdd6f4" })
		vim.api.nvim_set_hl(0, "NeoTreeSymbolicLinkTarget", { fg = "#cba6f7" })
	end,
}
