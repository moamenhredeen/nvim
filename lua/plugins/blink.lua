return {
	'saghen/blink.cmp',
	version = '*',
	opts = {
		keymap = {
			preset = "enter",
			['<C-e>'] = { 
				function(cmp)
					if cmp.is_visible() then
						return cmp.hide()
					else
						return cmp.show()
					end
				end,
				"fallback",
			},
      ['<C-space>'] = {},
			['<Tab>'] = {},
			['<S-Tab>'] = {},
		},
		appearance = {
			use_nvim_cmp_as_default = true,
			nerd_font_variant = 'mono'
		},
		cmdline = {
			enabled = false,
		},
		sources = {
			default = { 'lsp', 'path', 'snippets' },
		},
		completion = {
			menu = {
				auto_show = true,
			},
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 100,
			}
		},
		signature = { enabled = true },
	},
	opts_extend = { "sources.default" }
}
