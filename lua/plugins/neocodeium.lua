return {
	"monkoose/neocodeium",
	event = "VeryLazy",
	config = function()
		local neocodeium = require("neocodeium")
		neocodeium.setup()

		vim.keymap.set("i", "<Tab>", neocodeium.accept)
		vim.keymap.set("n", "<leader>cc", neocodeium.chat)
	end,
}
