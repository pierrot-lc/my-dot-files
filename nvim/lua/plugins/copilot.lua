return {
	-- GitHub Copilot extension. Use `:Copilot auth` to authenticate yourself.
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		keys = {
			{ "<leader>c", "<Cmd>Copilot suggestion toggle_auto_trigger<Cr>", desc = "Toggle GitHub Copilot" },
		},
		opts = {
			suggestion = {
				enabled = true,
				auto_trigger = true,
				keymap = {
					accept = "<M-l>",
					accept_word = false,
					accept_line = false,
					next = "<M-)>",
					prev = "<M-(>",
					dismiss = false,
				},
			},
			panel = {
				enabled = false,
			},
		},
	},
}
