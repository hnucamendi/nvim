return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
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
		formatters_by_ft = {
			lua = { "stylua" },
			javascript = { "prettier", "prettierd", "biome", stop_after_first = true },
			javascriptreact = { "prettier", "prettierd", "biome", stop_after_first = true },
			json = { "prettier", "prettierd", "biome", stop_after_first = true },
			typescript = { "prettier", "prettierd", "biome", stop_after_first = true },
			typescriptreact = { "prettier", "prettierd", "biome", stop_after_first = true },
			markdown = { "markdownlint", "prettier" },
			yaml = { "prettier" },
			cpp = { "clang-format" },
			java = { "clang-format" },
			css = { "prettier" },
			html = { "prettier" },
			go = { "gofumpt", "goimports" },
			python = { "black" },
			terraform = { "terraform" },
		},
	},
}
