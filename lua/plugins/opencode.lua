return {
	"nickjvandyke/opencode.nvim",
	version = "*", -- Latest stable release
	keys = {
		{ "<C-o>", mode = { "n", "t" }, desc = "Toggle opencode" },
	},
	dependencies = {
		{
			"folke/snacks.nvim",
			optional = true,
			opts = {
				input = {}, -- Enhances `ask()`
				picker = { -- Enhances `select()`
					actions = {
						opencode_send = function(...)
							return require("opencode").snacks_picker_send(...)
						end,
					},
					win = {
						input = {
							keys = {
								["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
							},
						},
					},
				},
				terminal = {}, -- Enables the `snacks` provider
			},
		},
	},
	config = function()
		vim.o.autoread = true

		vim.keymap.set({ "n", "t" }, "<C-o>", function()
			require("opencode").toggle()
		end, { desc = "Toggle opencode" })
	end,
}
