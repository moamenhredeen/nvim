-- *************************************************
-- zk-nvim — zettelkasten note taking via zk CLI
-- requires zk binary (~/tools/zk) and notebook at ~/notes
-- See :help zk and https://github.com/zk-org/zk-nvim

return {
	"zk-org/zk-nvim",
	config = function()

		-- let zk commands work from any cwd, not only inside the notebook
		vim.env.ZK_NOTEBOOK_DIR = vim.fn.expand("~/notes")

		require("zk").setup({
			picker = "telescope"
		})

		local zk_commands = require("zk.commands")

		local create_note = function () 
			vim.ui.input({ prompt = "Note title: " }, 
				function(title)
					if title and title ~= "" then
						zk_commands.get("ZkNew")({ title = title })
					end
			end)
		end

		local open_note = function()
			zk_commands.get("ZkNotes")({ sort = { "modified" } })
		end

		local search_notes = function()
			vim.ui.input({ prompt = "Search notes: " }, 
				function(query)
					if query and query ~= "" then
						zk_commands.get("ZkNotes")({ sort = { "modified" }, match = { query } })
					end
			end)
		end


		vim.keymap.set("n", "<Leader>zn", create_note)
		vim.keymap.set("n", "<Leader>zo", open_note)
		vim.keymap.set("n", "<Leader>zt", zk_commands.get("ZkTags"))
		vim.keymap.set("n", "<Leader>zf", search_notes)

		-- LSP attach + buffer-local maps for markdown files inside the notebook.
		-- zk-nvim's own auto-attach is broken on Windows (notebook_root fails on
		-- backslash paths), so attach manually here.
		local notebook_dir = vim.env.ZK_NOTEBOOK_DIR:gsub("\\", "/"):lower()
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "markdown",
			callback = function(event)

				local path = vim.api.nvim_buf_get_name(event.buf):gsub("\\", "/"):lower()

				if not vim.startswith(path, notebook_dir) then
					return
				end

				require("zk.lsp").buf_add(event.buf)

				vim.keymap.set("n", "<Leader>zb", zk_commands.get("ZkBacklinks"), { buffer = event.buf })
				vim.keymap.set("n", "<Leader>zl", zk_commands.get("ZkLinks"), { buffer = event.buf })
				vim.keymap.set("v", "<Leader>zn", ":'<,'>ZkNewFromTitleSelection<CR>", { buffer = event.buf })
			end,
		})
	end
}
