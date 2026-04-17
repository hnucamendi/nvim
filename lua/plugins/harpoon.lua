return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  keys = {
    -- disable lazyvim extra defaults
    { "<leader>H", false },
    { "<leader>h", false },
    { "<leader>5", false },
    -- harpoon list management
    {
      "<leader>a",
      function()
        require("harpoon"):list():add()
      end,
      desc = "Harpoon: add file",
    },
    {
      "<leader>A",
      function()
        require("harpoon"):list():remove()
      end,
      desc = "Harpoon: remove file",
    },
    -- navigation
    {
      "<C-m>",
      function()
        local h = require("harpoon")
        h.ui:toggle_quick_menu(h:list())
      end,
      desc = "Harpoon: toggle menu",
    },
    {
      "<C-n>",
      function()
        require("harpoon"):list():next()
      end,
      desc = "Harpoon: next file",
    },
    {
      "<C-p>",
      function()
        require("harpoon"):list():prev()
      end,
      desc = "Harpoon: prev file",
    },
    -- direct slot jumps
    {
      "<leader>1",
      function()
        require("harpoon"):list():select(1)
      end,
      desc = "Harpoon: file 1",
    },
    {
      "<leader>2",
      function()
        require("harpoon"):list():select(2)
      end,
      desc = "Harpoon: file 2",
    },
    {
      "<leader>3",
      function()
        require("harpoon"):list():select(3)
      end,
      desc = "Harpoon: file 3",
    },
    {
      "<leader>4",
      function()
        require("harpoon"):list():select(4)
      end,
      desc = "Harpoon: file 4",
    },
  },
}
