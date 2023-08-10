return {
	-- Debugger Adaptation Protocol.
	{
		"mfussenegger/nvim-dap",
		keys = {
			{ "<Leader>db", "<CMD>DapToggleBreakpoint<CR>", desc = "Toggle breakpoint" },
			{ "<Leader>dc", "<CMD>DapContinue<CR>", desc = "Run/Continue until next breakpoint" },
			{ "<Leader>do", "<CMD>DapStepOver<CR>", desc = "Step over" },
			{ "<Leader>di", "<CMD>DapStepInto<CR>", desc = "Step into" },
			{ "<Leader>dt", "<CMD>DapTerminate<CR>", desc = "Terminate" },
		},
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
			"mfussenegger/nvim-dap-python",
		},
		config = function()
			require("dap")

			local sign = vim.fn.sign_define
			sign("DapBreakpoint", { text = " ", texthl = "DapBreakpoint", linehl = "", numhl = "" })
			sign(
				"DapBreakpointCondition",
				{ text = " ", texthl = "DapBreakpointCondition", linehl = "", numhl = "" }
			)
			sign("DapLogPoint", { text = "◆ ", texthl = "DapLogPoint", linehl = "", numhl = "" })
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
	-- Shows variable values in virtual lines.
	{
		"theHamsta/nvim-dap-virtual-text",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		config = true,
	},
	-- DAP for Python.
	{
		"mfussenegger/nvim-dap-python",
		config = function()
			-- TODO: Dynamically setup the path below (so that it works on Nix).
			require("dap-python").setup("~/.local/share/nvim/mason/packages/debugpy/venv/bin/python")
		end,
	},
}
