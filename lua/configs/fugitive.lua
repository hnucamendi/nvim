return {
	"tpope/vim-fugitive",
	config = function()
		vim.keymap.set("n", "<leader>gs", ":Git<CR>", { desc = "[G]it [S]tatus (Fugitive)" })
		vim.keymap.set("n", "<leader>gb", ":Git blame<CR>", { desc = "[G]it [B]lame (inline)" })
		vim.keymap.set("n", "<leader>gl", ":0Gclog<CR>", { desc = "[G]it commit [L]og for this file" })

		-- 3-way merge helpers (works when a file has conflicts and you've opened a diff)
		vim.keymap.set("n", "<leader>co", ":diffget //2<CR>", { desc = "Take ours (LOCAL)" })
		vim.keymap.set("n", "<leader>ct", ":diffget //3<CR>", { desc = "Take theirs (REMOTE)" })
	end,
}
