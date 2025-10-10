return {
  "snacks.nvim",
  opts = function(_, opts)
    local art = require("plugins.utils.art")
    opts = opts or {}
    opts.dashboard = opts.dashboard or {}
    opts.dashboard.preset = opts.dashboard.preset or {}

    opts.dashboard.preset.header = art.scary

    opts.picker = opts.picker or {}
    opts.picker.hidden = true

    opts.explorer = opts.explorer or {}
    opts.explorer.enabled = true
  end,
}
