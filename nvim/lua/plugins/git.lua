return {
	--
	{
		"NeogitOrg/neogit",
		cmd = "Neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"sindrets/diffview.nvim",
		},
		config = true,
	},
	-- Show git signs.
	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		config = true,
	},
	-- Provide default gitignores.
	{
		"wintermute-cell/gitignore.nvim",
		cmd = "Gitignore",
		dependencies = { "nvim-telescope/telescope.nvim" },
	},
}
