return {
	-- Efficient parser, building a syntax tree for a source file.
	-- Provides some basic functionalities such as better highlighting.
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-refactor", -- Refactor modules.
			"nvim-treesitter/nvim-treesitter-textobjects", -- Syntax aware text-objects.
			-- TODO: text-objects!
		},
		event = "BufReadPost",
		config = function()
			require("nvim-treesitter.configs").setup({
				-- Parsers to install by defaults.
				ensure_installed = {
					"lua",
					"python",
					"markdown",
					"json",
					"yaml",
					"bash",
				},
				-- Highlight module.
				highlight = { enable = true },
				-- Refactor modules.
				refactor = {
					highlight_definitions = {
						enable = true,
						clear_on_cursor_move = true,
					},
					highlight_current_scope = { enable = true },
					smart_rename = {
						enable = true,
						keymaps = {
							smart_rename = "grr",
						},
					},
				},
			})
		end,
	},
}
