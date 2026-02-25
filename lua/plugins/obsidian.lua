return {
	"obsidian-nvim/obsidian.nvim",
	version = "*",
	-- ft = "markdown",
	dependencies = {
		"MeanderingProgrammer/render-markdown.nvim",
	},
	keys = {
		{ "<leader>pi", "<cmd>Obsidian paste_img<cr>", desc = "Obsidian Paste Image" },
		{ "<leader>ob", "<cmd>Obsidian<cr>", desc = "Obsidian" },
	},
	opts = {
		legacy_commands = false,
		workspaces = {
			{
				name = "personal",
				path = "~/obsidian/personal",
			},
			{
				name = "work",
				path = "~/obsidian/work",
			},
		},
	},
}
