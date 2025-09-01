return {

	{ -- Linting
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		keys = {
			{
				"<leader>l",
				function()
					if vim.opt_local.modifiable:get() then
						require("lint").try_lint()
					end
				end,
				mode = "",
				desc = "[L]int buffer",
			},
		},
		config = function()
			local lint = require("lint")
			lint.linters_by_ft = {
				markdown = { "markdownlint" },
				terraform = { "tflint" },
				json = { "jsonlint" },
				dockerfile = { "hadolint" },
				java = { "checkstyle" },
				javascript = { "eslint_d" },
				javascriptreact = { "eslint_d" },
				typescript = { "eslint_d" },
				typescriptreact = { "eslint_d" },
				yaml = { "yamllint", "actionlint" },
				go = { "golangcilint" },
				makefile = { "checkmake" },
				python = { "ruff" },

				-- Fallback & global buckets if you want them later:
				["_"] = { "typos" }, -- run when no ft-specific linter configured
				["*"] = { "typos" }, -- run for ALL filetypes
			}

			local function debounce(ms, fn)
				local timer = vim.uv.new_timer()
				return function(...)
					local argv = { ... }
					timer:start(ms, 0, function()
						timer:stop()
						vim.schedule(function()
							fn(unpack(argv))
						end)
					end)
				end
			end

			local function file_has_upwards(paths, filename)
				return vim.fs.find(paths, { path = filename, upward = true })[1] ~= nil
			end

			if lint.linters.eslint_d then
				lint.linters.eslint_d.condition = function(ctx)
					return file_has_upwards({
						".eslintrc",
						".eslintrc.js",
						".eslintrc.cjs",
						".eslintrc.json",
						"eslint.config.js",
						"eslint.config.cjs",
						"eslint.config.mjs",
						"eslint.config.ts",
					}, ctx.filename)
				end
			end

			lint.linters.golangcilint = vim.tbl_deep_extend("force", lint.linters.golangcilint or {}, {
				condition = function(ctx)
					return file_has_upwards({ "go.mod" }, ctx.filename)
				end,
				cwd = function(ctx)
					return vim.fn.fnamemodify(ctx.filename, ":h")
				end,
				-- If you want to restrict to current file, uncomment:
				-- args = { "run", "--out-format", "json", "--issues-exit-code=1", "--path-prefix", ".", "--", vim.api.nvim_buf_get_name(0) },
			})

			-- Example: run markdownlint only if a config exists (optional)
			if lint.linters.markdownlint then
				lint.linters.markdownlint.condition = function(ctx)
					return file_has_upwards(
						{ ".markdownlint.jsonc", ".markdownlint.json", ".markdownlint.yaml", ".markdownlint.yml" },
						ctx.filename
					) or true -- keep true to always run; flip to `false` here to require a config
				end
			end

			local function run_lint()
				-- Resolve linters from filetype (nvim-lint behavior)
				local names = lint._resolve_linter_by_ft(vim.bo.filetype)
				names = vim.list_extend({}, names)

				-- Add fallback (“_”) if no ft linters; then global (“*”)
				if #names == 0 then
					vim.list_extend(names, lint.linters_by_ft["_"] or {})
				end
				vim.list_extend(names, lint.linters_by_ft["*"] or {})

				-- Filter by existence + condition(ctx)
				local ctx = { filename = vim.api.nvim_buf_get_name(0) }
				ctx.dirname = vim.fn.fnamemodify(ctx.filename, ":h")
				names = vim.tbl_filter(function(name)
					local ltr = lint.linters[name]
					return ltr and not (type(ltr) == "table" and ltr.condition and not ltr.condition(ctx))
				end, names)

				if #names > 0 and vim.opt_local.modifiable:get() then
					lint.try_lint(names)
				end
			end

			-- Events (LazyVim defaults): run after read, after write, and when leaving insert
			local grp = vim.api.nvim_create_augroup("nvim-lint", { clear = true })
			vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
				group = grp,
				callback = debounce(100, run_lint),
			})
		end,
	},
}
