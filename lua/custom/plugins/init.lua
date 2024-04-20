-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

return {
  {
    'nvim-tree/nvim-tree.lua',
    version = '*',
    lazy = false,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('nvim-tree').setup {
        git = {
          enable = true,
        },
        disable_netrw = true,
        sort = {
          sorter = 'name',
        },
        view = {
          centralize_selection = true,
        },
        filters = {
          dotfiles = false,
          git_ignored = false,
        },
      }
    end,
  },
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },

    config = function()
      local harpoon = require 'harpoon'
      -- REQUIRED
      harpoon:setup()
      -- REQUIRED

      vim.keymap.set('n', '<leader>a', function()
        harpoon:list():add()
      end, { desc = 'add current file to harpoon buffer' })

      vim.keymap.set('n', '<C-e>', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, { desc = 'toggle quick harpoon quick select menu' })

      vim.keymap.set('n', '<C-j>', function()
        harpoon:list():select(1)
      end, { desc = 'switch to harpoon file in slot 1' })
      vim.keymap.set('n', '<C-i>', function()
        harpoon:list():select(2)
      end, { desc = 'switch to harpoon file in slot 2' })
      vim.keymap.set('n', '<C-o>', function()
        harpoon:list():select(3)
      end, { desc = 'switch to harpoon file in slot 3' })
      vim.keymap.set('n', '<C-p>', function()
        harpoon:list():select(4)
      end, { desc = 'switch to harpoon file in slot 4' })

      vim.keymap.set('n', '<leader><', function()
        harpoon:list():prev()
      end, { desc = 'testing' })
      vim.keymap.set('n', '<leader>>', function()
        harpoon:list():next()
      end)
    end,
  },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require('catppuccin').setup {
        flavour = 'mocha', -- latte, frappe, macchiato, mocha
        -- flavour = "auto" -- will respect terminal's background
        background = { -- :h background
          light = 'latte',
          dark = 'mocha',
        },
        transparent_background = true, -- disables setting the background color.
        show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
        term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
        dim_inactive = {
          enabled = false, -- dims the background color of inactive window
          shade = 'dark',
          percentage = 0.15, -- percentage of the shade to apply to the inactive window
        },
        no_italic = false, -- Force no italic
        no_bold = false, -- Force no bold
        no_underline = false, -- Force no underline
        styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
          comments = { 'italic' }, -- Change the style of comments
          conditionals = { 'italic' },
          loops = {},
          functions = {},
          keywords = { 'italic' },
          strings = {},
          variables = {},
          numbers = {},
          booleans = {},
          properties = {},
          types = {},
          operators = {},
          -- miscs = {}, -- Uncomment to turn off hard-coded styles
        },
        color_overrides = {},
        custom_highlights = {},
        default_integrations = true,
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          treesitter = true,
          notify = false,
          mini = {
            enabled = true,
            indentscope_color = '',
          },
          -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
        },
      }

      -- setup must be called before loading
      vim.cmd.colorscheme 'catppuccin'
    end,
  },
  {
    'tpope/vim-fugitive',
    config = function()
      vim.keymap.set('n', '<leader>G', ':Git<CR>')
    end,
  },
  {
    'mbbill/undotree',
    config = function()
      vim.keymap.set('n', '<leader>Gd', ':UndotreeShow<CR>')
    end,
  },
  {
    'kdheepak/lazygit.nvim',
    cmd = {
      'LazyGit',
      'LazyGitConfig',
      'LazyGitCurrentFile',
      'LazyGitFilter',
      'LazyGitFilterCurrentFile',
    },
    -- optional for floating window border decoration
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    keys = {
      { '<leader>lg', '<cmd>LazyGit<cr>', desc = 'LazyGit' },
      { '<leader>lc', '<cmd>LazyGitCurrentFile<cr>', desc = 'LazyGit Current File' },
      { '<leader>lf', '<cmd>LazyGitFilterCurrentFile<cr>', desc = 'LazyGit Current File' },
      { '<leader>lF', '<cmd>LazyGitFilter<cr>', desc = 'LazyGit Current File' },
    },
  },
}
