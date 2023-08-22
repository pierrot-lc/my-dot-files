return {
	-- Add/remove f-string.
	-- TODO: Make a shortcut only when inside a python file.
	{
		"roobert/f-string-toggle.nvim",
		ft = "python",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		keys = {
			{ "<LocalLeader>f", "<CMD>lua require('f-string-toggle').toggle_fstring()<CR>", desc = "Toggle f-string" },
		},
	},
}
