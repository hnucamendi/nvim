vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex) -- open file explorer

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv") -- move text line down
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv") -- move text line up

vim.keymap.set("n", "J", "mzJ`z") -- move line below up int line with cursor
vim.keymap.set("n", "<C-d>", "<C-d>zz") -- scroll down with cursor centered
vim.keymap.set("n", "<C-u>", "<C-u>zz") -- scroll up with cursor centered
vim.keymap.set("n", "n", "nzzzv") -- /{word} searches remain centered
vim.keymap.set("n", "N", "Nzzzv") -- /{word} searches reamin centered

vim.keymap.set("n", "<leader>vwm", function()
    require("vim-with-me").StartVimWithMe()
end)
vim.keymap.set("n", "<leader>svwm", function()
    require("vim-with-me").StopVimWithMe()
end)

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]]) -- deletes line without adding to buffer and pastes previous line in buffer

-- next greatest remap ever : asbjornHaland
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]]) -- yanks to clipboard
vim.keymap.set("n", "<leader>Y", [["+Y]]) -- yanks line to clipboard

vim.keymap.set({"n", "v"}, "<leader>d", [["_d]]) -- deletes line to black hole

-- This is going to get me cancelled
-- vim.keymap.set("i", "<C-c>", "<Esc>") -- makes C-c act as esc in insert mode

vim.keymap.set("n", "Q", "<nop>") -- disables regular "Q" behaviour
-- vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>") -- no idea
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format) -- format file

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz") -- easy navigate quick fix?
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz") -- easy navigate quick fix?
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz") -- easy navigate location list?
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz") -- easy navigate location list?

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]) -- replace
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true }) -- makes file executable

vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>"); -- wodnerfull

vim.keymap.set("n", "<leader><leader>", function() -- runs :so?
    vim.cmd("so")
end)
