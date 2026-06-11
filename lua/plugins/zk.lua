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

		local open_graph = function()
			local notebook = vim.fn.expand("~/notes")
			local template = notebook .. "/graph-viewer.html"
			local tmp = vim.fn.tempname() .. ".html"

			local f = io.open(template, "r")
			if not f then
				vim.notify("graph-viewer.html not found in " .. notebook, vim.log.levels.ERROR)
				return
			end
			local html = f:read("*a")
			f:close()

			local json = vim.fn.system("zk graph --format=json --quiet")
			-- use function replacement to avoid Lua treating % in JSON as pattern escapes
			html = html:gsub("__GRAPH_JSON__", function() return json end, 1)

			local out = io.open(tmp, "w")
			if not out then return end
			out:write(html)
			out:close()

			vim.ui.open(tmp)
		end

		vim.keymap.set("n", "<Leader>zg", open_graph, { desc = "Open knowledge graph" })

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
