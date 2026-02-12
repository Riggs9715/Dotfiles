vim.pack.add({
	{ src = "https://github.com/saghen/blink.cmp", version = vim.version.range("^1.7.0") },
	"https://github.com/L3MON4D3/LuaSnip",
	"https://github.com/rafamadriz/friendly-snippets",
})

require("luasnip.loaders.from_vscode").lazy_load()
require("blink.cmp").setup({
	completion = {
		accept = { auto_brackets = { enabled = true } },
		menu = {
			auto_show = true,
			draw = {
				treesitter = { "lsp" },
				columns = { { "kind_icon", "label", "label_description", gap = 1 }, { "kind" } },
			},
		},
		documentation = { auto_show = true, auto_show_delay_ms = 500 },
	},
	signature = { enabled = true },
})
