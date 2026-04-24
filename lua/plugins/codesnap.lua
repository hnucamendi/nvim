return {
  "mistricky/codesnap.nvim",
  tag = "v1.0.0",
  build = "make",
  config = function()
    require("codesnap").setup({
      bg_x_padding = 20,
      bg_y_padding = 20,
      bg_padding = 0,
    })
  end,
}
