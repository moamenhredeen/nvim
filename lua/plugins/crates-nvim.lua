-- *************************************************
-- make nvim rust IDE 😎
--

return {
	'saecki/crates.nvim',
	tag = 'stable',
	event = { "BufRead Cargo.toml" },
	config = function()
		local crates = require('crates')
		crates.setup()

		local opts = { silent = true }

		local nmap = function(key, command)
			vim.keymap.set("n", key, command, opts)
		end

		nmap("<localleader>t", crates.toggle)
		nmap("<localleader>r", crates.reload)

		nmap("<localleader>v", crates.show_versions_popup)
		nmap("<localleader>f", crates.show_features_popup)
		nmap("<localleader>d", crates.show_dependencies_popup)

		nmap("<localleader>u", crates.update_crate)
		nmap("<localleader>a", crates.update_all_crates)
		nmap("<localleader>U", crates.upgrade_crate)
		nmap("<localleader>A", crates.upgrade_all_crates)

		nmap("<localleader>x", crates.expand_plain_crate_to_inline_table)
		nmap("<localleader>X", crates.extract_crate_into_table)

		nmap("<localleader>H", crates.open_homepage)
		nmap("<localleader>R", crates.open_repository)
		nmap("<localleader>D", crates.open_documentation)
		nmap("<localleader>C", crates.open_crates_io)
		nmap("<localleader>L", crates.open_lib_rs)

		vim.keymap.set("v", "<localleader>u", crates.update_crates, opts)
		vim.keymap.set("v", "<localleader>U", crates.upgrade_crates, opts)
	end
}
