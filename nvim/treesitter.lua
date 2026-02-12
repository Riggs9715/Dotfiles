vim.pack.add({
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
})

require("nvim-treesitter").install({
	"hyprlang",
	"lua",
	"qmljs",
})

vim.o.foldlevel = 99
vim.o.foldlevelstart = 99

vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		if vim.bo.buftype ~= "" or vim.bo.filetype == "dashboard" then
			return
		end
		vim.treesitter.start()
		vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
		vim.wo.foldmethod = "expr"
		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})
