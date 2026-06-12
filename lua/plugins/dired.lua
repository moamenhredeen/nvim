return {
	"moamenhredeen/dired.nvim",
	branch = "main",
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
