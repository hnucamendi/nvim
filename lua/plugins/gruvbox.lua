-- lua/plugins/gruvbox.lua
return {
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    opts = {
      contrast = "soft", -- affects both dark and light, gives "light-soft" when light
      transparent_mode = false,
      terminal_colors = true,
    },
    config = function(_, opts)
      require("gruvbox").setup(opts)
      -- don't decide light/dark here; we'll do it via autocmds/util
    end,
  },

  -- Tell LazyVim our default theme is gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },
}
