return {
	{
		"vidocqh/data-viewer.nvim",
		ft = { "csv", "tsv" },
		cmd = "DataViewer",
		dependencies = {
			"nvim-lua/plenary.nvim",
			-- "kkharji/sqlite.lua", -- Optional, sqlite support.
		},
		opts = {
			autoDisplayWhenOpenFile = true,
			columnColorEnable = false,
		},
	},
}
