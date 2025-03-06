
vim.keymap.set("n", "<localleader>f", function ()
	require("telescope.builtin").find_files {
		cwd = vim.fn.stdpath("data")
	}
end, {silent = true})
