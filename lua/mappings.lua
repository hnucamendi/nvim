local map = function(keys, func, opts)
	opts = opts or {}
	local mode = opts.mode or "n"
	local desc = opts.desc or ""
	local remap = opts.remap or false
	vim.keymap.set(mode, keys, func, { desc = desc, remap = remap })
end

vim.api.nvim_create_user_command("DeleteFile", function(args)
	local file = vim.fn.expand("%:p") -- Get the absolute path of the current file

	-- Ensure the file exists before attempting to delete
	if vim.fn.filereadable(file) == 0 then
		print("Error: File does not exist or is not readable: " .. file)
		return
	end

	-- Confirm deletion
	if vim.fn.confirm("Delete file and its buffer (Non-Recoverable)?\n" .. file, "&Yes\n&No") == 1 then
		-- Delete the buffer if bang is used
		if args.bang then
			vim.cmd("bdelete!")
		end

		-- Attempt to delete the file
		local success, err = pcall(os.remove, file)
		if success then
			-- Print appropriate success message
			if args.bang then
				print("File and buffer have been nuked: " .. file)
			else
				print("File has been nuked: " .. file)
			end
		else
			print("Error deleting file: " .. err)
		end
	end
end, {
	bang = true, -- Allow the `!` modifier for "nuke" mode
	desc = "Delete current file (and buffer if bang `!` is used)",
})

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to ee if you like it!
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Set the default tabstop to 2
vim.opt.expandtab = true -- Converts tabs to spaces globally
vim.opt.tabstop = 2 -- Tab width is 2 spaces
vim.opt.shiftwidth = 2 -- Indentation is 2 spaces
vim.opt.softtabstop = 2 -- Tab key inserts 2 spaces

-- Turn off line wraps
vim.opt.wrap = false

-- Override local tabstop settings on BufEnter
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*",
	callback = function()
		vim.opt_local.expandtab = true -- Converts tabs to spaces globally
		vim.opt_local.tabstop = 2 -- Tab width is 2 spaces
		vim.opt_local.shiftwidth = 2 -- Indentation is 2 spaces
		vim.opt.softtabstop = 2 -- Tab key inserts 2 spaces
	end,
})

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Decrease update time
vim.opt.updatetime = 50

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = "  ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 8

vim.opt.isfname:append("@-@")

-- Turn off Swapfile
-- vim.opt.swapfile = false

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
map("<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
map("<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
map("<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode", mode = "t" })

-- TIP: Disable arrow keys in normal mode
map("<left>", '<cmd>echo "Use h to move!!"<CR>')
map("<right>", '<cmd>echo "Use l to move!!"<CR>')
map("<up>", '<cmd>echo "Use k to move!!"<CR>')
map("<down>", '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
map("<C-h>", "<C-w><C-h>", "Move focus to the left window")
map("<C-l>", "<C-w><C-l>", "Move focus to the right window")
map("<C-j>", "<C-w><C-j>", "Move focus to the lower window")
map("<C-k>", "<C-w><C-k>", "Move focus to the upper window")

map("<leader>n", function()
	vim.opt.relativenumber = false
	vim.opt.number = not vim.opt.number:get()
end, { desc = "toggle line number" })

map("<leader>rn", function()
	vim.opt.number = true
	vim.opt.relativenumber = not vim.opt.relativenumber:get()
end, { desc = "toggle relative line number" })

-- Move lines
map("<A-k>", ":m .-2<CR>==", { desc = "Move current line up" })
map("<A-j>", ":m .+1<CR>==", { desc = "Move current line down" })
map("<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up", mode = "v" })
map("<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down", mode = "v" })

-- Duplicate the current line down, respecting repeat counts
map("<leader>j", function()
	local count = vim.v.count == 0 and 1 or vim.v.count -- Default to 1 if no count is provided
	vim.cmd("normal! yy" .. count .. "p") -- Yank the current line and paste `count` times below
end, { desc = "Duplicate current line down" })

map("<leader>-", "gcc", { desc = "[C]omment line of [C]ode", remap = true })
map("<leader>-", "gc", { desc = "[C]omment line of [C]ode", mode = "v", remap = true })

map("<leader>dX", ":DeleteFile!<CR>", { desc = "[D]elete current file AND buffer (Not recoverable)" })
map("<leader>dF", ":DeleteFile<CR>", { desc = "[D]elete current [F]ile" })

vim.keymap.set("n", "<leader>T", function()
	-- Get the current buffer's directory
	local current_dir = vim.fn.expand("%:p:h")

	-- Create a scratch buffer for the terminal
	local buf = vim.api.nvim_create_buf(false, true)

	-- Open a horizontal split at 15% height
	vim.cmd("belowright 15sp")
	vim.api.nvim_win_set_buf(0, buf)

	-- Open the terminal in the buffer and set its working directory
	vim.fn.termopen(vim.o.shell, { cwd = current_dir })

	-- Apply terminal window-specific options (using vim.wo for the current window)
	vim.wo.number = false
	vim.wo.relativenumber = false
	vim.wo.signcolumn = "no"
	vim.wo.cursorline = false

	-- Automatically enter insert mode in the terminal
	vim.cmd("startinsert")
end, { desc = "Open terminal at 15% height" })

vim.keymap.set("n", "<leader>H", function()
	vim.cmd("split") -- Open a horizontal split
	vim.cmd("enew") -- Create a new empty buffer
	vim.bo.buftype = "nofile" -- Set buffer as scratch (not backed by a file)
	vim.bo.bufhidden = "hide" -- Hide buffer when abandoned
	vim.bo.swapfile = false -- Disable swap file
end, { desc = "Open Scratch Buffer" })

-- Move to the next buffer
map("<Tab>", ":bNext<CR>", { desc = "Next buffer" })
-- Move to the previous buffer
map("<S-Tab>", ":bprevious<CR>", { desc = "Previous buffer" })
-- Close the current buffer
map("<leader>bd", ":bdelete<CR>", { desc = "Close buffer" })

map("<leader>e", ":Explore<CR>", { desc = "[E]xplore Open Netrw" })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
