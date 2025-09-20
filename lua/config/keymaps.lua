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

local harpoon = require("harpoon")
harpoon:setup()

map("<C-n>", function()
  harpoon:list():next()
end, { desc = "Next Harpoon file" })

map("<C-p>", function()
  harpoon:list():prev()
end, { desc = "Previous Harpoon file" })
