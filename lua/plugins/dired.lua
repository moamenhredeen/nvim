return {
	-- local checkout for testing the Rust core; restore the line below when done
	-- "moamenhredeen/dired.nvim", branch = "main",
	dir = "/home/moamen/git-repos/dired.nvim",
	dependencies = {
		"ej-shafran/compile-mode.nvim",
	},
	config = function()
		require("dired").setup {
			override_cwd = false,
			path_separator = "/",
			show_banner = false,
			show_icons = false,
			show_hidden = true,
			show_dot_dirs = true,
			show_colors = true,
		}
	end
}
