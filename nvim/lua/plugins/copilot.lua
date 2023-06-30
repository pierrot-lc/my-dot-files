return {
	-- GitHub Copilot extension. Use `:Copilot auth` to authenticate yourself.
	{
		"zbirenbaum/copilot.lua",
		enabled = true,
		cmd = "Copilot",
		event = "InsertEnter",
		keys = {
			{ "<Leader>c", "<CMD>Copilot suggestion toggle_auto_trigger<CR>", desc = "Toggle GitHub Copilot" },
		},
		opts = {
			suggestion = {
				enabled = true,
				auto_trigger = false, -- Start suggesting as soon as you start typing.
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
}
