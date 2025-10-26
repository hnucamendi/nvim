-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = function(keys, func, opts)
  opts = opts or {}
  local mode = opts.mode or "n"
  local desc = opts.desc or ""
  local remap = opts.remap or false
  vim.keymap.set(mode, keys, func, { desc = desc, remap = remap })
end

-- Disable Snacks explorer binding from LazyVim defaults
pcall(vim.keymap.del, "n", "<leader>e")
map("<leader>e", vim.cmd.Ex, { desc = "Open netrw" })

local harpoon = require("harpoon")
harpoon:setup()

map("<C-n>", function()
  harpoon:list():next()
end, { desc = "Next Harpoon file" })

map("<C-p>", function()
  harpoon:list():prev()
end, { desc = "Previous Harpoon file" })

map("<leader>a", function()
  harpoon:list():add()
end, { desc = "Add Harpoon file" })

map("<leader>A", function()
  harpoon:list():remove()
end, { desc = "Remove Harpoon file" })
