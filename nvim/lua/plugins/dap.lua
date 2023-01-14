return {
	-- Debugger Adaptation Protocol.
	{
		"mfussenegger/nvim-dap",
		keys = {
			{ "<leader>Db", "<cmd>DapToggleBreakpoint<cr>", "Toggle breakpoint" },
			{ "<leader>Dc", "<cmd>DapContinue<cr>", "Run/Continue until next breakpoint" },
			{ "<leader>Do", "<cmd>DapToggleRepl<cr>", "Toggle DAP interface" },
		},
		dependencies = {
			"rcarriga/nvim-dap-ui",
			{ "mfussenegger/nvim-dap-python", config = true }, -- DAP for Python.
		},
	},
	-- DAP interface.
	{
		"rcarriga/nvim-dap-ui",
		lazy = true,
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			dapui.setup()

			-- Automatically open and close UI when launching DAP.
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open({})
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close({})
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close({})
			end
		end,
	},
}
