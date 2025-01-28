return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")

		harpoon:setup()

		-- Keybindings
		vim.keymap.set("n", "<leader>a", function()
			harpoon:list():add()
		end, { desc = "Add file to Harpoon" })

		vim.keymap.set("n", "<leader>A", function()
			harpoon:list():remove()
		end, { desc = "Add file to Harpoon" })

		vim.keymap.set("n", "<C-m>", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end, { desc = "Toggle Harpoon menu" })

		vim.keymap.set("n", "<C-n>", function()
			harpoon:list():next()
		end, { desc = "Next Harpoon file" })

		vim.keymap.set("n", "<C-p>", function()
			harpoon:list():prev()
		end, { desc = "Previous Harpoon file" })

		-- Optional: Directly jump to specific slots
		vim.keymap.set("n", "<leader>1", function()
			harpoon:list():select(1)
		end, { desc = "Harpoon file 1" })

		vim.keymap.set("n", "<leader>2", function()
			harpoon:list():select(2)
		end, { desc = "Harpoon file 2" })

		vim.keymap.set("n", "<leader>3", function()
			harpoon:list():select(3)
		end, { desc = "Harpoon file 3" })

		vim.keymap.set("n", "<leader>4", function()
			harpoon:list():select(4)
		end, { desc = "Harpoon file 4" })
	end,
}
