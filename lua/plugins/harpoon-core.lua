local M = {}

function M.setup()
  local ok, harpoon = pcall(require, "harpoon-core")
  if not ok then
    return
  end

  harpoon.setup({})

  local map = vim.keymap.set
  local function info(message)
    print(message)
  end

  local function current_name()
    local name = vim.fn.expand("%:t")
    if name == "" then
      return "[No Name]"
    end

    return name
  end

  -- harpoon core
  map("n", "<leader>ml", function()
    harpoon.toggle_quick_menu()
    info("Harpoon menu toggled")
  end, { desc = "harpoon view" })
  map("n", "<leader>ma", function()
    harpoon.add_file()
    info("File added: " .. current_name())
  end, { desc = "harpoon add" })
  map("n", "<leader>mr", function()
    harpoon.rm_file()
    info("File removed: " .. current_name())
  end, { desc = "harpoon add" })
  map("n", "<C-l>", function()
    harpoon.nav_next()
    info("Moved to next harpoon file")
  end, { desc = "harpoon next" })
  map("n", "<C-h>", function()
    harpoon.nav_prev()
    info("Moved to previous harpoon file")
  end, { desc = "harpoon prev" })

  -- number based navigation
  map("n", "<A-1>", function()
    harpoon.nav_file(1)
    info("Moved to harpoon file 1")
  end, { desc = "harpoon 1" })
  map("n", "<A-2>", function()
    harpoon.nav_file(2)
    info("Moved to harpoon file 2")
  end, { desc = "harpoon 2" })
  map("n", "<A-3>", function()
    harpoon.nav_file(3)
    info("Moved to harpoon file 3")
  end, { desc = "harpoon 3" })
  map("n", "<A-4>", function()
    harpoon.nav_file(4)
    info("Moved to harpoon file 4")
  end, { desc = "harpoon 4" })
  map("n", "<A-5>", function()
    harpoon.nav_file(5)
    info("Moved to harpoon file 5")
  end, { desc = "harpoon 5" })
end

return M
