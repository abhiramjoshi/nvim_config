return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"leoluz/nvim-dap-go",
			"mfussenegger/nvim-dap-python",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			dapui.setup()
			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end

			vim.keymap.set("n", "<F5>", dap.continue, {})
			vim.keymap.set("n", "<F6>", dap.step_over, {})
			vim.keymap.set("n", "<F7>", dap.step_into, {})
			vim.keymap.set("n", "<F8>", dap.step_out, {})
			vim.keymap.set("n", "<Leader>bt", dap.toggle_breakpoint, {})
			vim.keymap.set("n", "<Leader>bs", dap.set_breakpoint, {})
			-- vim.keymap.set("n", "<Leader>lp", dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: ")), {})
			-- vim.keymap.set("n", "<Leader>dr", dap.repl.open, {})
			-- vim.keymap.set("n", "<Leader>dl", dap.run_last, {})
			-- Config for Go
      require("dap-go").setup()
      -- Config for Debugpy
			require("dap-python").setup("/Users/abhiramj/global_python_tools/bin/python")
			-- dap.adapters.python = function(cb, config)
			-- 	if config.request == "attach" then
			-- 		---@diagnostic disable-next-line: undefined-field
			-- 		local port = (config.connect or config).port
			-- 		---@diagnostic disable-next-line: undefined-field
			-- 		local host = (config.connect or config).host or "127.0.0.1"
			-- 		cb({
			-- 			type = "server",
			-- 			port = assert(port, "`connect.port` is required for a python `attach` configuration"),
			-- 			host = host,
			-- 			options = {
			-- 				source_filetype = "python",
			-- 			},
			-- 		})
			-- 	else
			-- 		cb({
			-- 			type = "executable",
			-- 			command = "/Users/abhiramj/global_python_tools/bin/python",
			-- 			args = { "-m", "debugpy.adapter" },
			-- 			options = {
			-- 				source_filetype = "python",
			-- 			},
			-- 		})
			-- 	end
			-- end
			-- dap.configurations.python = {
			-- 	{
			-- 		-- The first three options are required by nvim-dap
			-- 		type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
			-- 		request = "launch",
			-- 		name = "Launch file",

			-- 		-- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

			-- 		program = "${file}", -- This configuration will launch the current file if used.
			-- 		pythonPath = function()
			-- 			-- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
			-- 			-- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
			-- 			-- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
			-- 			local cwd = vim.fn.getcwd()
			-- 			if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
			-- 				return cwd .. "/venv/bin/python"
			-- 			elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
			-- 				return cwd .. "/.venv/bin/python"
			-- 			else
			-- 				return "/usr/bin/python"
			-- 			end
			-- 		end,
			-- 	},
			-- }
		end,
	},
}
