return {
	"akinsho/toggleterm.nvim",
	version = "*",
	opts = function()
		-- size function keeps ~15% height for horizontal terminals
		local function horiz_size()
			return math.max(7, math.floor(vim.o.lines * 0.15))
		end

		-- smart project root (prefer LSP root; fallback to markers; finally CWD)
		local function project_root()
			local buf = vim.api.nvim_get_current_buf()
			local clients = vim.lsp.get_clients({ bufnr = buf })
			if clients[1] and clients[1].config and clients[1].config.root_dir then
				return clients[1].config.root_dir
			end
			local dir = vim.fn.expand("%:p:h")
			while dir and dir ~= "/" do
				for _, m in ipairs({ ".git", "package.json", "go.mod", "Makefile", "Dockerfile" }) do
					if vim.fn.isdirectory(dir .. "/" .. m) == 1 or vim.fn.filereadable(dir .. "/" .. m) == 1 then
						return dir
					end
				end
				dir = vim.fn.fnamemodify(dir, ":h")
			end
			return vim.loop.cwd()
		end

		return {
			start_in_insert = true,
			shade_terminals = false,
			persist_size = false,
			hide_numbers = true,
			direction = "horizontal", -- default; we’ll override per-terminal via keymaps
			size = horiz_size,
			close_on_exit = true,
			on_create = function(term)
				-- set cwd when a terminal is first created
				pcall(term.set_dir, term, project_root())
			end,
		}
	end,
	config = function(_, opts)
		require("toggleterm").setup(opts)

		local Terminal = require("toggleterm.terminal").Terminal

		-- Terminal #1: "server" – use FLOAT so it never steals layout space
		local server = Terminal:new({
			count = 1,
			dir = "git_dir",
			direction = "float",
			float_opts = { border = "rounded" },
			on_open = function(t)
				vim.cmd("startinsert")
			end,
		})

		-- Terminal #2: "misc" – bottom split at ~15% height, reused not stacked
		local misc = Terminal:new({
			count = 2,
			dir = "git_dir",
			direction = "horizontal",
			on_open = function(t)
				vim.cmd("startinsert")
			end,
		})

		-- Keymaps (match your leader scheme)
		local map = function(lhs, rhs, desc, mode)
			vim.keymap.set(mode or "n", lhs, rhs, { desc = desc })
		end

		-- <leader>T → toggle "misc" bottom terminal (replaces your current mapping)
		map("<leader>T", function()
			misc:toggle()
		end, "Toggle misc terminal")

		-- <leader>TS → toggle "server" as a FLOAT (logs without changing splits)
		map("<leader>F", function()
			server:toggle()
		end, "Toggle server terminal (float)")

		-- Quality-of-life: easy terminal-mode escape
		vim.keymap.set("t", "<Esc><Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })
	end,
}
