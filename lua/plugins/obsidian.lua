return {
	"obsidian-nvim/obsidian.nvim",
	version = "*",
	-- ft = "markdown",
	dependencies = {
		"MeanderingProgrammer/render-markdown.nvim",
	},
	keys = {
		{ "<C-p>", "<cmd>Obsidian paste_img<cr>", desc = "Obsidian Paste Image" },
		{ "<C-b>", "<cmd>Obsidian<cr>", desc = "Obsidian" },
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
