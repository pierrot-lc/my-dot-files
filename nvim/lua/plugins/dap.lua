return {
	-- Debugger Adaptation Protocol.
	{
		"mfussenegger/nvim-dap",
		keys = {
			{ "<leader>Db", "<cmd>DapToggleBreakpoint<cr>", desc = "Toggle breakpoint" },
			{ "<leader>Dc", "<cmd>DapContinue<cr>", desc = "Run/Continue until next breakpoint" },
			{ "<leader>Do", "<cmd>DapToggleRepl<cr>", desc = "Toggle DAP interface" },
		},
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"mfussenegger/nvim-dap-python",
		},
		config = function()
			require("dap")

			-- Override default highlight groups (for catppuccin).
			local sign = vim.fn.sign_define
			sign("DapBreakpoint", { text = "", texthl = "DapBreakpoint", linehl = "", numhl = "" })
			sign("DapBreakpointCondition", { text = "", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
			sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })
		end,
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
	-- DAP for Python.
	{
		"mfussenegger/nvim-dap-python",
		config = function()
			require("dap-python").setup("~/.local/share/nvim/mason/packages/debugpy/venv/bin/python")
		end,
	},
}
