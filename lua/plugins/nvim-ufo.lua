return {
	"kevinhwang91/nvim-ufo",
	event = "BufRead",
	dependencies = "kevinhwang91/promise-async",
	config = function()
		require("ufo").setup({
			fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
				local newVirtText = {}
				local suffix = (" 󰁂 %d "):format(endLnum - lnum)
				local sufWidth = vim.fn.strdisplaywidth(suffix)
				local targetWidth = width - sufWidth
				local curWidth = 0
				for _, chunk in ipairs(virtText) do
					local chunkText = chunk[1]
					local chunkWidth = vim.fn.strdisplaywidth(chunkText)
					if targetWidth > curWidth + chunkWidth then
						-- Use Folded highlight group for all content to ensure transparency
						table.insert(newVirtText, { chunkText, "Folded" })
					else
						chunkText = truncate(chunkText, targetWidth - curWidth)
						-- Use Folded highlight group for all content to ensure transparency
						table.insert(newVirtText, { chunkText, "Folded" })
						chunkWidth = vim.fn.strdisplaywidth(chunkText)
						-- str width returned from truncate() may less than 2nd argument, need padding
						if curWidth + chunkWidth < targetWidth then
							suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
						end
						break
					end
					curWidth = curWidth + chunkWidth
				end
				table.insert(newVirtText, { suffix, "Folded" })
				return newVirtText
			end,
		})
	end,
}
