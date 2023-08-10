-- Mason is disabled if we're using Nix (Nix should handle the package installations).
if vim.fn.executable("nix") == 1 then
	return {}
end

return {
	-- Package manager for LSP servers, DAP, linters and formatters.
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		keys = {
			{ "<Leader>pm", "<CMD>Mason<CR>", desc = "Mason" },
		},
		config = true,
	},
	-- Automatically install Null-ls sources using Mason.
	{
		"jay-babu/mason-null-ls.nvim",
		event = "VeryLazy",
		dependencies = {
			"williamboman/mason.nvim",
			"jose-elias-alvarez/null-ls.nvim",
		},
		opts = { automatic_installation = true },
	},
	-- Automatically install lspconfig sources using Mason.
	{
		"williamboman/mason-lspconfig.nvim",
		event = "VeryLazy",
		dependencies = {
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		opts = { automatic_installation = true },
	},
	-- Automatically install debug protocols.
	{
		"jay-babu/mason-nvim-dap.nvim",
		event = "VeryLazy",
		dependencies = {
			"williamboman/mason.nvim",
			"mfussenegger/nvim-dap",
		},
		opts = {
			automatic_installation = true,
		},
	},
}
