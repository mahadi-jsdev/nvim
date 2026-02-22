return {
	"CopilotC-Nvim/CopilotChat.nvim",
	dependencies = {
		{ "nvim-lua/plenary.nvim", branch = "master" },
	},
	build = "make tiktoken",
	opts = {
		prompts = {
			Commit = {
				prompt = [[ Write commit message for the change with commitizen convention. Give a good title under 50 characters and make commit message as list and as detailed as possible. Format as a gitcommit code block. ]],
				resources = {
					"gitdiff:staged",
				},
			},
		},
	},
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
