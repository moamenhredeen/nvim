local tmp_buf = vim.api.nvim_create_buf(false, true)
return {
	-- create scratch buffer for note taking while coding
	-- - create temporary buffer
	-- - open it in a vertical split
	-- - set the filetype to markdown
	create_scratch_buffer = function()
		vim.cmd('vnew')                    -- create a vertical split
		vim.api.nvim_win_set_buf(0, tmp_buf) -- 0 for current window

		-- set some options specific to this temporary buffer
		vim.bo.filetype = "markdown"
	end
}
