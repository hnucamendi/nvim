return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")

		harpoon:setup()

		-- Keybindings
		vim.keymap.set("n", "<leader>c+", function()
			harpoon:list():add()
		end, { desc = "Add file to Harpoon" })

		vim.keymap.set("n", "<leader>c-", function()
			harpoon:list():remove()
		end, { desc = "Add file to Harpoon" })

		vim.keymap.set("n", "<leader>tm", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end, { desc = "Toggle Harpoon menu" })

		vim.keymap.set("n", "<leader>wn", function()
			harpoon:list():next()
		end, { desc = "Next Harpoon file" })

		vim.keymap.set("n", "<leader>wp", function()
			harpoon:list():prev()
		end, { desc = "Previous Harpoon file" })

		-- Optional: Directly jump to specific slots
		vim.keymap.set("n", "<leader>w1", function()
			harpoon:list():select(1)
		end, { desc = "Harpoon file 1" })

		vim.keymap.set("n", "<leader>w2", function()
			harpoon:list():select(2)
		end, { desc = "Harpoon file 2" })

		vim.keymap.set("n", "<leader>w3", function()
			harpoon:list():select(3)
		end, { desc = "Harpoon file 3" })

		vim.keymap.set("n", "<leader>w4", function()
			harpoon:list():select(4)
		end, { desc = "Harpoon file 4" })
	end,
}
