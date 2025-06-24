return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	cmd = "FzfLua",
	config = function()
		require("fzf-lua").setup({
			files = { fd_opts = [[--color=never --hidden --type f --type l --exclude --no-ignore -g '!.git/']] },
			grep = {
				rg_opts = "--hidden --no-ignore --column --line-number --no-heading --color=always --smart-case --max-columns=4096 -e",
			},
			oldfiles = { include_current_session = true },
			previewers = { builtin = { syntax_limit_b = 1024 * 100 } },
		})

		local fzf = require("fzf-lua")
		vim.keymap.set("n", "<leader>sf", function()
			fzf.files()
		end, { desc = "[S]earch [F]iles" })
		vim.keymap.set("n", "<leader>sg", function()
			fzf.live_grep()
		end, { desc = "[S]earch by [G]rep" })
		vim.keymap.set("n", "<leader>sw", function()
			fzf.grep_cword()
		end, { desc = "[S]earch current [W]ord" })
		vim.keymap.set("n", "<leader>sd", function()
			fzf.diagnostics_document()
		end, { desc = "[S]earch [D]iagnostics" })
		vim.keymap.set("n", "<leader>sr", function()
			fzf.resume()
		end, { desc = "[S]earch [R]esume" })
		vim.keymap.set("n", "<leader>s.", function()
			fzf.oldfiles()
		end, { desc = "[S]earch Recent Files" })
		vim.keymap.set("n", "<leader><leader>", function()
			fzf.buffers()
		end, { desc = "[ ] Find Buffers" })
	end,
}
