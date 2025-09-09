return {
	"akinsho/bufferline.nvim",
	version = "*", -- latest stable
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		options = {
			diagnostics = "nvim_lsp", -- show LSP diagnostics in tabs
			separator_style = "slant", -- example style
		},
	},
}
