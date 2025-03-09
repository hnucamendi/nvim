return { -- Autoformat
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		-- hel
		{
			"<leader>f",
			function()
				require("conform").format({ async = true, lsp_format = "fallback" })
			end,
			mode = "",
			desc = "[F]ormat buffer",
		},
	},
	opts = {
		notify_on_error = true,
		-- format_on_save = function(bufnr)
		-- 	-- Disable "format_on_save lsp_fallback" for languages that don't
		-- 	-- have a well standardized coding style. You can add additional
		-- 	-- languages here or re-enable it for the disabled ones.
		-- 	local disable_filetypes =
		-- 		{ c = true, cpp = true, js = false, mjs = false, ts = false, javascript = false, typescript = false }
		-- 	local lsp_format_opt
		-- 	if disable_filetypes[vim.bo[bufnr].filetype] then
		-- 		lsp_format_opt = "never"
		-- 	else
		-- 		lsp_format_opt = "fallback"
		-- 	end
		-- 	return {
		-- 		timeout_ms = 500,
		-- 		lsp_format = lsp_format_opt,
		-- 	}
		-- end,
		formatters_by_ft = {
			lua = { "stylua" },
			-- Conform can also run multiple formatters sequentially
			--
			-- You can use 'stop_after_first' to run the first available formatter from the list
			javascript = { "prettier", "prettierd", stop_after_first = true },
			javascriptreact = { "prettier", "prettierd", stop_after_first = true },
			typescript = { "prettierd" },
			typescriptreact = { "prettier", "prettierd", stop_after_first = true },
			markdown = { "prettier" },
			yaml = { "prettier" },
			cpp = { "clang-format" },
			java = { "clang-format" },
			css = { "prettier" },
			html = { "prettier" },
			go = { "goimports", "gofmt" },
		},
	},
}
