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
				-- Manipulate text-objects.
				textobjects = {
					-- Adding text-objects to select operators.
					select = {
						enable = true,
						lookahead = true,
						keys = {
							["af"] = { query = "@function.outer", desc = "Select outer part of a function region" },
							["if"] = { query = "@function.inner", desc = "Select inner part of a function region" },
							["ac"] = { query = "@class.outer", desc = "Select outer part of a class region" },
							["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
						},
					},
					-- Swap two text-objects.
					swap = {
						enable = true,
						swap_next = {
							["<leader>s"] = "@parameter.inner",
						},
						swap_previous = {
							["<leader>S"] = "@parameter.inner",
						},
					},
					-- Move around text-objects.
					move = {
						enable = true,
						set_jumps = true,
						goto_next_start = {
							["]m"] = "@function.outer",
							["]]"] = { query = "@class.outer", desc = "Next class start" },
						},
						goto_next_end = {
							["]M"] = "@function.outer",
							["]["] = "@class.outer",
						},
						goto_previous_start = {
							["[m"] = "@function.outer",
							["[["] = "@class.outer",
						},
						goto_previous_end = {
							["[M"] = "@function.outer",
							["[]"] = "@class.outer",
						},
					},
					-- Peek definition code using built-in LSP.
					lsp_interop = {
						enable = true,
						peek_definition_code = {
							["<leader>df"] = "@function.outer",
							["<leader>dF"] = "@class.outer",
						},
					},
				},
			})
		end,
	},
}
