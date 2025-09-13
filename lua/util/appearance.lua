-- lua/util/appearance.lua
local M = {}

-- macOS: returns true if system is in Dark Mode
function M.system_is_dark()
  local handle = io.popen("defaults read -g AppleInterfaceStyle 2>/dev/null")
  if not handle then
    return false
  end
  local result = handle:read("*a") or ""
  handle:close()
  return result:match("Dark") ~= nil
end

-- Apply Gruvbox variant based on system appearance
function M.apply_gruvbox_by_system()
  -- Guard in case plugin isn't ready yet
  local ok = pcall(require, "gruvbox")
  if not ok then
    return
  end

  if M.system_is_dark() then
    vim.o.background = "dark"
  else
    vim.o.background = "light" -- with contrast="soft" this becomes light-soft
  end
  vim.cmd.colorscheme("gruvbox")
end

return M
