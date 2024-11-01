-- package json specifiy keybindings
if vim.fn.expand("%:t") == "package.json" then
	-- Toggle dependency versions
	vim.keymap.set({ "n" }, "<localleader>t", require("package-info").toggle, { silent = true, noremap = true })

	-- Update dependency on the line
	vim.keymap.set({ "n" }, "<localleader>u", require("package-info").update, { silent = true, noremap = true })

	-- Delete dependency on the line
	vim.keymap.set({ "n" }, "<localleader>d", require("package-info").delete, { silent = true, noremap = true })

	-- Install a new dependency
	vim.keymap.set({ "n" }, "<localleader>i", require("package-info").install, { silent = true, noremap = true })

	-- Install a different dependency version
	vim.keymap.set({ "n" }, "<localleader>c", require("package-info").change_version, { silent = true, noremap = true })
end
