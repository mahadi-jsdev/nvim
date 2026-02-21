return {
	"CopilotC-Nvim/CopilotChat.nvim",
	dependencies = {
		{ "nvim-lua/plenary.nvim", branch = "master" },
	},
	build = "make tiktoken",
	opts = {},
	keys = {
		{
			"<leader>cc",
			"<CMD>CopilotChatToggle<CR>",
			desc = "Toggle Copilot Chat",
		},
		{
			"<leader>cm",
			"<CMD>CopilotChatCommit<CR>",
			desc = "Copilot Chat commit",
		},
	},
}
