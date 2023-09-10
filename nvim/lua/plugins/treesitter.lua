return {
	-- Efficient parser, building a syntax tree for a source file.
	-- Provides some basic functionalities such as better highlighting.
	{
		"nvim-treesitter/nvim-treesitter",
		event = "BufReadPost",
		keys = {
			{ "gR", desc = "Smart rename" },
		},
		build = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-refactor", -- Refactor modules.
			"nvim-treesitter/nvim-treesitter-textobjects", -- Syntax aware text-objects.
			"HiPhish/rainbow-delimiters.nvim", -- Switch delimiters colors to better distinguish them.
			"calops/hmts.nvim", -- Highlight languages contained in nix strings.
		},
		config = function()
			require("nvim-treesitter.configs").setup({
				-- Parsers to install by defaults.
				ensure_installed = {
					"bash",
					"json",
					"latex",
					"lua",
					"markdown",
					"nix",
					"norg",
					"python",
					"vimdoc",
					"yaml",
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
						node_incremental = "<TAB>",
						node_decremental = "<S-TAB>",
						scope_incremental = false,
					},
				},
				-- Refactor modules.
				refactor = {
					highlight_definitions = {
						enable = true,
						clear_on_cursor_move = true,
					},
					highlight_current_scope = { enable = false },
					smart_rename = {
						enable = true,
						keymaps = {
							smart_rename = "gR",
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
							["<Leader>ls"] = { query = "@parameter.inner", desc = "Swap with the next parameter" },
						},
						swap_previous = {
							["<Leader>lS"] = { query = "@parameter.inner", desc = "Swap with the previous parameter" },
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
							["<Leader>lf"] = { query = "@function.outer", desc = "Show function definition" },
							["<Leader>lc"] = { query = "@class.outer", desc = "Show class definition" },
						},
					},
				},
			})

			-- Use treesitter expressions for folds.
			vim.opt.foldmethod = "expr"
			vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
		end,
	},
	-- Enhanced folding.
	{
		"kevinhwang91/nvim-ufo",
		event = "BufReadPost",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"kevinhwang91/promise-async",
		},
		config = function()
			vim.opt.foldcolumn = "0"
			vim.opt.foldlevel = 99
			vim.opt.foldlevelstart = 99
			vim.opt.foldenable = true

			require("ufo").setup({
				provider_selector = function(bufnr, filetype, buftype)
					return { "treesitter", "indent" }
				end,
			})
		end,
	},
	-- Switch delimiters colors to better distinguish them.
	{
		"HiPhish/rainbow-delimiters.nvim",
		config = function()
			local rainbow_delimiters = require("rainbow-delimiters")
			vim.g.rainbow_delimiters = {
				strategy = {
					[""] = rainbow_delimiters.strategy["local"],
				},
				query = {
					[""] = "rainbow-delimiters",
					lua = "rainbow-blocks",
				},
				highlight = {
					"RainbowDelimiterRed",
					"RainbowDelimiterYellow",
					"RainbowDelimiterBlue",
					"RainbowDelimiterOrange",
					"RainbowDelimiterGreen",
					"RainbowDelimiterViolet",
					"RainbowDelimiterCyan",
				},
			}
		end,
	},
}
