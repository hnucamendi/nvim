return {
  "snacks.nvim",
  opts = function(_, opts)
    local art = require("plugins.utils.art")
    opts = opts or {}
    opts.dashboard = opts.dashboard or {}
    opts.dashboard.preset = opts.dashboard.preset or {}

    opts.dashboard.preset.header = art.scary
  end,
}
