return {
	-- GitHub Copilot extension. Use `:Copilot auth` to authenticate yourself.
	{
		"zbirenbaum/copilot.lua",
		enabled = true,
		cmd = "Copilot",
		event = "InsertEnter",
		keys = {
			{ "<leader>c", "<Cmd>Copilot suggestion toggle_auto_trigger<Cr>", desc = "Toggle GitHub Copilot" },
		},
		opts = {
			suggestion = {
				enabled = true,
				auto_trigger = true, -- Start suggesting as soon as you start typing.
				keymap = {
					accept = "<M-h>",
					accept_word = "<M-l>",
					accept_line = false,
					next = "<M-k>",
					prev = "<M-j>",
					dismiss = false,
				},
			},
			panel = {
				enabled = false,
			},
		},
	},
	-- Add Copilot as a source to `nvim-cmp`.
	{
		"zbirenbaum/copilot-cmp",
		enabled = true,
		dependencies = "zbirenbaum/copilot.lua",
		config = function()
			require("copilot_cmp").setup({
				formatters = {
					label = require("copilot_cmp.format").format_label_text,
					insert_text = require("copilot_cmp.format").remove_existing,
					preview = require("copilot_cmp.format").deindent,
				},
			})
		end,
	},
}
