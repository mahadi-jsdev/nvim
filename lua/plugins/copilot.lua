return {
	"zbirenbaum/copilot.lua",
	dependencies = {
		"AndreM222/copilot-lualine",
	},
	event = "InsertEnter",
	config = function()
		require("copilot").setup({
			panel = {
				enabled = true,
				auto_refresh = true,
				keymap = {
					jump_prev = "[[",
					jump_next = "]]",
					accept = "<CR>",
					refresh = "gr",
					open = "<M-CR>",
				},
				layout = {
					position = "bottom",
					ratio = 0.4,
				},
			},
			suggestion = {
				enabled = true,
				auto_trigger = true,
				hide_during_completion = true,
				debounce = 15,
				trigger_on_accept = true,
				keymap = {
					accept = "<Tab>",
					accept_word = false,
					accept_line = false,
					next = "<M-]>",
					prev = "<M-[>",
					dismiss = "<C-]>",
					toggle_auto_trigger = false,
				},
			},
			nes = {
				enabled = false,
			},
		})
	end,
}
