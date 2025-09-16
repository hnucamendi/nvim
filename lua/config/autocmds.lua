-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

local aug = vim.api.nvim_create_augroup("AppearanceAuto", { clear = true })
local function safe_apply()
  vim.schedule(function()
    pcall(require, "util.appearance")
    local ok, appearance = pcall(require, "util.appearance")
    if ok and appearance.set_vim_background then
      appearance.set_vim_background()
    end
  end)
end

-- Apply at startup (first UI attach) and when UI is re-created (e.g., after sleep)
vim.api.nvim_create_autocmd({ "VimEnter", "UIEnter" }, {
  group = aug,
  callback = safe_apply,
})

-- Optional: also re-check when focus returns to the editor
vim.api.nvim_create_autocmd("FocusGained", {
  group = aug,
  callback = safe_apply,
})

-- Manual sync command
vim.api.nvim_create_user_command("SyncSystemTheme", function()
  safe_apply()
  vim.notify("System theme synced to macOS appearance", vim.log.levels.INFO)
end, {})
