return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "auto",
      background = {
        light = "latte",
        dark = "frappe",
      },
    },
  },
  {
    { "LazyVim/LazyVim", opts = { colorscheme = "catppuccin" } },
  },
}
