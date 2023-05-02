-- Specific kitty plugins.

-- Make sure we're in kitty.
if vim.fn.expand("$TERM") ~= "xterm-kitty" then
	return {}
end

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
