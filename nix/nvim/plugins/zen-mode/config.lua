require("zen-mode").setup({
	window = {
		options = {
			number = false, -- Disable number column.
			signcolumn = "no",
			cursorline = false,
			cursorcolumn = false,
			foldcolumn = "0", -- Disable fold column.
		},
	},
	plugins = {
		tmux = {
			enabled = true,
		},
		gitsigns = {
			enabled = true,
		},
	},
	on_open = function(_)
		vim.diagnostic.disable()
	end,
	on_close = function()
		vim.diagnostic.enable()
	end,
})
