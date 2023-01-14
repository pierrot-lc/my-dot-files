return {
	-- Efficient parser, building a syntax tree for a source file.
	-- Provides some basic functionalities such as better highlighting.
	{
		"nvim-treesitter/nvim-treesitter",
		event = "BufReadPost",
		build = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-refactor", -- Refactor modules.
			"nvim-treesitter/nvim-treesitter-textobjects", -- Syntax aware text-objects.
		},
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
				-- Highlight based on treesitter.
				highlight = { enable = true },
				-- Indentation based on treesitter.
				ident = { enable = true },
				-- Incremental selection in the parsed tree.
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "gn",
						node_incremental = "<tab>",
						node_decremental = "<s-tab>",
						scope_incremental = false,
					},
				},
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
						keymaps = {
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
							["<leader>Ls"] = { query = "@parameter.inner", desc = "Swap with the next parameter" },
						},
						swap_previous = {
							["<leader>LS"] = { query = "@parameter.inner", desc = "Swap with the previous parameter" },
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
							["<leader>Lf"] = { query = "@function.outer", desc = "Show function definition" },
							["<leader>Lc"] = { query = "@class.outer", desc = "Show class definition" },
						},
					},
				},
			})

			-- Use treesitter expressions for folds.
			vim.opt.foldmethod = "expr"
			vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
			vim.opt.foldenable = false -- Disable folding by default
		end,
	},
}
