return {

  -- render-markdown hides raw syntax (**,  _, [^1], etc.) in normal mode.
  -- Start disabled so you always see raw markdown. Toggle with <leader>um.
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      enabled = false,
    },
  },

  -- Only use prettier for markdown formatting. markdownlint-cli2's --fix mode
  -- strips "unused" footnote definitions (MD053 and similar rules).
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      opts.formatters_by_ft.markdown = { "prettier" }
      return opts
    end,
  },

  -- Live browser preview synced to cursor position. Requires Node.js.
  -- <leader>mp to toggle.
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    keys = {
      { "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", ft = "markdown", desc = "Preview (browser)" },
    },
    config = function()
      vim.g.mkdp_auto_close = 0
      vim.g.mkdp_preview_options = {
        sync_scroll_type = "middle",
        disable_sync_scroll = 0,
      }
    end,
  },

  -- Grammar and style checking via LanguageTool as an LSP.
  -- Catches repeated words, wrong articles, punctuation — beyond spellcheck.
  -- Install with :MasonInstall ltex-ls
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ltex = {
          settings = {
            ltex = {
              language = "en-US",
              disabledRules = {
                ["en-US"] = {
                  "WHITESPACE_RULE",
                  "EN_QUOTES",
                },
              },
              dictionary = {
                ["en-US"] = {},
              },
              -- Don't flag code blocks or front matter
              markdown = {
                nodes = { "CodeBlock", "FencedCode", "AutoLink" },
                action = "ignoreSentence",
              },
            },
          },
        },
      },
    },
  },

  -- Table editing: type || on a blank line to enter table mode.
  -- Columns auto-align as you type. <leader>tt to toggle, <leader>tf to realign.
  {
    "dhruvasagar/vim-table-mode",
    ft = { "markdown" },
    keys = {
      { "<leader>tt", "<cmd>TableModeToggle<cr>",  ft = "markdown", desc = "Toggle table mode" },
      { "<leader>tf", "<cmd>TableModeRealign<cr>", ft = "markdown", desc = "Realign table" },
    },
    config = function()
      vim.g.table_mode_corner          = "|"
      vim.g.table_mode_header_fillchar = "-"
      vim.g.table_mode_auto_align      = 1
    end,
  },

  -- Heading-aware navigation and folding without touching rendering.
  -- ]] / [[ — next/prev heading   ge — follow link   zo/zc — fold section
  {
    "preservim/vim-markdown",
    ft = { "markdown" },
    dependencies = { "godlygeek/tabular" },
    config = function()
      vim.g.vim_markdown_conceal            = 0
      vim.g.vim_markdown_conceal_code_blocks = 0
      vim.g.vim_markdown_folding_disabled   = 0
      vim.g.vim_markdown_folding_style_pythonic = 1
      vim.g.vim_markdown_follow_anchor      = 1
      vim.g.vim_markdown_frontmatter        = 1
      vim.g.vim_markdown_toml_frontmatter   = 1
      vim.g.vim_markdown_new_list_item_indent = 2
    end,
  },

  -- gx on [text](url) opens the URL. gx on [[wiki-link]] navigates to the file.
  {
    "jghauser/follow-md-links.nvim",
    ft = { "markdown" },
  },

  -- Centered 80-column writing column with all UI chrome hidden.
  -- <leader>mz to toggle. Pairs with twilight for paragraph focus.
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    keys = {
      { "<leader>mz", "<cmd>ZenMode<cr>", desc = "Zen mode (focus writing)" },
    },
    opts = {
      window = {
        width = 80,
        options = {
          number         = false,
          relativenumber = false,
          signcolumn     = "no",
          foldcolumn     = "0",
          colorcolumn    = "",
        },
      },
      plugins = {
        twilight = { enabled = true },
        gitsigns = { enabled = false },
        tmux     = { enabled = true },
      },
    },
  },

  -- Dims everything outside the paragraph your cursor is in.
  -- <leader>mT to toggle independently of zen mode.
  {
    "folke/twilight.nvim",
    cmd = "Twilight",
    keys = {
      { "<leader>mT", "<cmd>Twilight<cr>", desc = "Twilight (dim surroundings)" },
    },
    opts = {
      dimming = { alpha = 0.35 },
      context = 8,
      expand  = { "function", "method", "table", "if_statement", "paragraph", "block_quote" },
    },
  },

}
