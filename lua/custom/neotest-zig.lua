local lib = require("neotest.lib")

---@class neotest.ZigAdapter
local _M = {}


_M._test_treesitter_query = [[
	;;query
    (test_declaration
        [(identifier) (string)] @test.name
    ) @test.definition
]]


_M._parse_options = {
	nested_tests = true,
	require_namespaces = true,
	position_id = function(postion, parents)
		return postion.id
	end
}

---@param node neotest.Tree
---@return string
function _M._get_zig_symbol_name_from_node(node)
    -- Tests in Zig can be named either by a string, or by another declaration.
    local test_name = ""
    local test_name_starts_with_doublequote = string.sub(node:data().name, 1, 1) == "\""
    if test_name_starts_with_doublequote then
        test_name = "test." .. string.sub(node:data().name, 2, string.len(node:data().name) - 1)
    else
        test_name = "decltest." .. node:data().name
    end
    return test_name
end

function _M._get_temp_file_path()
    return vim.fs.normalize(async.fn.tempname())
end


---Find the project root directory given a current directory to work from.
---Should no root be found, the adapter can still be used in a non-project context if a test file matches.
---@async
---@param dir string @Directory to treat as cwd
---@return string | nil @Absolute root dir of test suite
function _M.root(dir)
	return dir
end

---Filter directories when searching for test files
---@async
---@param name string Name of directory
---@param rel_path string Path to directory, relative to root
---@param root string Root directory of project
---@return boolean
function _M.filter_dir(name, rel_path, root)
	return true
end


---@async
---@param file_path string
---@return boolean
function _M.is_test_file(file_path)
	local result = vim.endswith(file_path, ".zig")
	if (result) then
    local content = lib.files.read(file_path)
    local tree = lib.treesitter.parse_positions_from_string(file_path, content, _M._test_treesitter_query, _M._parse_options)
    return next(tree:children()) ~= nil
	end
	return result
end

---Given a file path, parse all the tests within it.
---@async
---@param file_path string Absolute file path
---@return neotest.Tree | nil
function _M.discover_positions(file_path)
	local positions = lib.treesitter.parse_positions(file_path, _M._test_treesitter_query,  _M._parse_options)
	return positions
end

---@param args neotest.RunArgs
---@return nil | neotest.RunSpec | neotest.RunSpec[]
function _M.build_spec(args)
	local neotest_inputs = {}
	for _, node in args.tree:iter_nodes() do
		if node:data().type ~= "test" then
			goto continue
		end

		local test_name = _M._get_zig_symbol_name_from_node(node)

		table.insert(neotest_inputs, {
			test_name = test_name,
			source_path = node:data().path,
			output_path = _M._get_temp_file_path(),
		})
		::continue::
	end

	local neotest_input_path = _M._get_temp_file_path()
	local neotest_input_json = vim.json.encode(neotest_inputs)
	-- local success_writing, test_results_json = pcall(lib.files.write, neotest_input_path, neotest_input_json)

	local neotest_results_path = _M._get_temp_file_path()

	-- TODO: use vim.fn.mkdir instead
	vim.loop.fs_mkdir(neotest_results_path, 493) -- Ensure tests results dir before running tests.
	local this_script_path = vim.fs.normalize(debug.getinfo(1).source:sub(2))
	local source_neotest_build_file_path = vim.fs.normalize(
	vim.fn.resolve(this_script_path .. "../../../../zig/neotest_build.zig"))
	local test_runner_path = vim.fs.normalize(
	vim.fn.resolve(this_script_path .. "../../../../zig/neotest_runner.zig"))

	local build_file_dir_path = build_file_path:match("(.*[/\\])")
	local target_neotest_build_file_path = build_file_dir_path .. "neotest_build.zig";

	local success, errmsg = vim.loop.fs_copyfile(source_neotest_build_file_path, target_neotest_build_file_path)
	if not success then
		log.error("Could not copy from", source_neotest_build_file_path, "to", target_neotest_build_file_path)
		return
	end

	local context = {
		temp_neotest_build_file_path = target_neotest_build_file_path,
		test_results_dir_path = neotest_results_path,
	}

	-- Test runner logs have a separate directory, because
	-- Zig may launch multiple processes, where each process
	-- would write into a separate log file.
	local test_runner_logs_dir_path = M._get_temp_file_path()
	vim.loop.fs_mkdir(test_runner_logs_dir_path, 493)

	local zig_test_command = M.path_to_zig ..
	' build test' ..
	' --build-file "' .. target_neotest_build_file_path .. '"' ..
	' -Dneotest-runner="' .. test_runner_path .. '"' ..
	' -- ' ..
	' --neotest-input-path "' .. neotest_input_path .. '"' ..
	' --neotest-results-path "' .. neotest_results_path .. '"' ..
	' --test-runner-logs-path "' .. test_runner_logs_dir_path .. '"' ..
	' --test-runner-log-level "' .. log.get_log_level() .. '"'

	return {
		command = zig_test_command,
		context = context,
	}
end

---@async
---@param spec neotest.RunSpec
---@param result neotest.StrategyResult
---@param tree neotest.Tree
---@return table<string, neotest.Result>
function _M.results(spec, result, tree)
	return {}
end

return _M
