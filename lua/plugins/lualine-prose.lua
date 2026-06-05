local word_count = {
  function()
    if _G.MarkdownWordCount then
      return _G.MarkdownWordCount()
    end
    return ""
  end,
  cond  = function() return vim.bo.filetype == "markdown" end,
  color = { fg = "#a0a8b8" },
}

local spell_lang = {
  function()
    if vim.opt_local.spell:get() then
      return "  " .. vim.opt_local.spelllang:get()[1]
    end
    return ""
  end,
  cond  = function() return vim.bo.filetype == "markdown" end,
  color = { fg = "#a0a8b8" },
}

local zen_indicator = {
  function()
    return vim.g.zen_mode_active and "  zen" or ""
  end,
  cond  = function() return vim.bo.filetype == "markdown" end,
  color = { fg = "#7c9e7e" },
}

return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    table.insert(opts.sections.lualine_x, 1, word_count)
    table.insert(opts.sections.lualine_x, 2, spell_lang)
    table.insert(opts.sections.lualine_y, 1, zen_indicator)
    return opts
  end,
}
