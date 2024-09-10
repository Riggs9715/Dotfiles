return {
	'arnamak/stay-centered.nvim',
	config = function()
		require('stay-centered').setup({
			enabled = true,
			skip_filetypes = {}
		})
	end
}
