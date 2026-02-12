vim.pack.add({
	"https://github.com/m4xshen/hardtime.nvim",
	"http://github.com/MunifTanjim/nui.nvim",
})

require("hardtime").setup({
	enabled = true,
	-- time in ms to cosider key presses as repeated
	max_time = 1000,
	-- max repeated key presses allowed within max_time
	max_count = 3,
	restriction_mode = "block",
	-- a different key press resets the count
	allow_different_key = true,
	disable_mouse = true,
	force_exit_insert_mode = true,
	max_insert_idle_ms = 10000,
	hint = true,
	notification = true,
	-- duration of notification
	timeout = 3000,
})
