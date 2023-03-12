return {
	{
		"nvim-neorg/neorg",
		ft = "norg",
		cmd = "Neorg",
		build = ":Neorg sync-parsers",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"folke/zen-mode.nvim",
			"hrsh7th/nvim-cmp",
		},
		opts = {
			load = {
				-- Loads default behaviour.
						["core.defaults"] = {},
				-- Adds pretty icons to your documents.
						["core.norg.concealer"] = {},
				-- Manages Neorg workspaces.
						["core.norg.dirman"] = {
					config = {
						workspaces = {
							notes = "~/Notes",
						},
					},
				},
				-- Add completion support.
						["core.norg.completion"] = {
					config = {
						engine = "nvim-cmp",
					},
				},
				-- Make any Norg file presentable.
				-- Use the `:Neorg presenter start` command.
						["core.presenter"] = {
					config = {
						zen_mode = "zen-mode",
					},
				},
			},
		},
	},
}