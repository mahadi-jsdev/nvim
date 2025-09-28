return {
	"nvim-telescope/telescope.nvim",
	event = "VeryLazy",
	config = function()
		require("telescope").setup({
			defaults = {
				path_display = {
					filename_first = {
						reverse_directories = true,
					},
				},
				prompt_prefix = "   ",
				selection_caret = " ❯ ",
				layout_strategy = "horizontal",
				layout_config = { prompt_position = "top" },
				sorting_strategy = "ascending",
				winblend = 0,
				preview = {
					-- hide_on_startup = true,
				},
				file_ignore_patterns = {
					"node_modules",
					".next",
					"package-lock.json",
					"bun.lock",
					"pnpm-lock.yaml",
				},
			},
			pickers = {
				find_files = {
					find_command = { "rg", "--files", "--sortr=modified" },
				},
			},
		})

		local map = vim.keymap.set
		local builtin = require("telescope.builtin")

		map("n", "<leader>ff", builtin.find_files, { desc = "find files" })
		map("n", "<C-f>", builtin.live_grep, { desc = "Telescope live grep" })
		map("n", "<C-b>", builtin.buffers, { desc = "Telescope buffers" })
		map("n", "<C-g>", builtin.git_status, { desc = "git status" })
	end,
}
