local M = {}

function M.system_is_dark()
  local handle = io.popen("defaults read -g AppleInterfaceStyle 2>/dev/null")
  if not handle then
    return false
  end
  local result = handle:read("*a") or ""
  handle:close()
  return result:match("Dark") ~= nil
end

function M.set_vim_background()
  if M.system_is_dark() then
    vim.o.background = "dark"
  else
    vim.o.background = "light"
  end
end

return M
