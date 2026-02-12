vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set("n", "<leader>t", ":Neotree focus left <CR>")
vim.keymap.set("n", "<leader>T", ":Neotree close <CR>")

vim.keymap.set("n", "<leader>ca", function()
	vim.lsp.buf.code_action()
end, { desc = "LSP Code Action", noremap = true, silent = true })

vim.keymap.set("n", "<leader>ff", ":Telescope find_files <CR>", { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", ":Telescope live_grep <CR>", { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fb", ":Telescope buffers <CR>", { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fh", ":Telescope help_tags <CR>", { desc = "Telescope find files" })

vim.keymap.set("n", "<leader>lr", ":Telescope lsp_references <CR>", { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fd", ":Telescope diagnostics <CR>", { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>li", ":Telescope lsp_implementations <CR>", { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>ld", ":Telescope lsp_definitions <CR>", { desc = "Telescope find files" })
