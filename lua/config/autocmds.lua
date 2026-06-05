-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("markdown_writing", { clear = true }),
  pattern = "markdown",
  callback = function(ev)
    local buf = ev.buf
    local opt = vim.opt_local

    -- Show all raw syntax characters; LazyVim's markdown extra sets this to 2
    opt.conceallevel = 0
    opt.colorcolumn  = ""

    -- Soft-wrap at word boundaries so long lines don't scroll horizontally
    opt.wrap        = true
    opt.linebreak   = true
    opt.breakindent = true

    -- Spell checking (]s/[s navigate, z= suggests, zg adds to dict)
    opt.spell      = true
    opt.spelllang  = "en_us"

    -- Prevent Neovim from inserting hard line breaks while typing
    opt.textwidth = 0
    opt.formatoptions:remove({ "t", "a" })

    -- Visual-line movement: j/k/0/^/$ follow wrapped lines, not file lines
    local map = function(lhs, rhs)
      vim.keymap.set({ "n", "x" }, lhs, rhs, { buffer = buf, silent = true })
    end
    map("j", "gj")
    map("k", "gk")
    map("0", "g0")
    map("^", "g^")
    map("$", "g$")

    -- <leader>fn — insert an auto-numbered footnote at cursor, jump to its definition
    vim.keymap.set("n", "<leader>fn", function()
      local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
      local n = 0
      for _, line in ipairs(lines) do
        if line:match("^%[%^%d+%]%s*:") then n = n + 1 end
      end
      local next_n = n + 1
      local marker = string.format("[^%d]", next_n)
      local defn   = string.format("[^%d]: ", next_n)

      local row, col = unpack(vim.api.nvim_win_get_cursor(0))
      local cur_line = lines[row]
      vim.api.nvim_buf_set_lines(buf, row - 1, row, false, {
        cur_line:sub(1, col) .. marker .. cur_line:sub(col + 1),
      })

      local last = #lines
      if lines[last] ~= "" then
        vim.api.nvim_buf_set_lines(buf, last, last, false, { "" })
        last = last + 1
      end
      vim.api.nvim_buf_set_lines(buf, last, last, false, { defn })
      vim.api.nvim_win_set_cursor(0, { last + 1, #defn })
      vim.cmd("startinsert!")
    end, { buffer = buf, desc = "Insert footnote" })

    -- <leader>fj — jump to the definition of the footnote reference under cursor
    vim.keymap.set("n", "<leader>fj", function()
      local ref = vim.fn.expand("<cWORD>"):match("%[%^(%d+)%]")
      if not ref then
        vim.notify("No footnote reference under cursor", vim.log.levels.WARN)
        return
      end
      local pattern = string.format("^%[%^%s%]%s*:", ref)
      for i, line in ipairs(vim.api.nvim_buf_get_lines(buf, 0, -1, false)) do
        if line:match(pattern) then
          vim.api.nvim_win_set_cursor(0, { i, 0 })
          return
        end
      end
      vim.notify("Footnote definition [^" .. ref .. "] not found", vim.log.levels.WARN)
    end, { buffer = buf, desc = "Jump to footnote definition" })

    -- Live word count exposed globally so lualine can call it
    _G.MarkdownWordCount = function()
      local text = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), " ")
      text = text:gsub("^%-%-%-.-%-%-%-", "")   -- strip YAML front matter
      text = text:gsub("```.-```", "")           -- strip fenced code blocks
      text = text:gsub("%[.-%]%(.-%)", "")       -- strip inline links
      text = text:gsub("[#*_`~]", "")            -- strip markdown markers
      local _, count = text:gsub("%S+", "")
      return "  " .. count .. " words"
    end
  end,
})
