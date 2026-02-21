return {
	"CopilotC-Nvim/CopilotChat.nvim",
	dependencies = {
		{ "nvim-lua/plenary.nvim", branch = "master" },
	},
	build = "make tiktoken",
	opts = {
		prompts = {
			Commit = {
				prompt = [[Write a detailed commit message using the Commitizen convention:
        - Begin with a clear type and optional scope, in the format: type(scope): summary
        - Add a concise, descriptive summary/title for the change
        - Provide a detailed description as a bulleted list
        - Reference related issues (e.g., Closes #123) if applicable
        - Format the message as a `gitcommit` code block

        Example types: feat, fix, docs, chore, style, refactor, test, build
        ]],
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
