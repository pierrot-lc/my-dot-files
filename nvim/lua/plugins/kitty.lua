-- Specific kitty plugins.
return {
	-- Kitty configuration highlights.
	{
		"fladson/vim-kitty",
		ft = "kitty",
	},
	-- Make kitty terminal colors match vim colors.
	{
		"shaun-mathew/Chameleon.nvim",
		enabled = true,
		config = true,
	},
}
