return {
	-- Classic vim theme.
	{
		"sainnhe/gruvbox-material",
		enabled = false,
		dependencies = { "bluz71/nvim-linefly" },
		lazy = false,
		priority = 1000,
		config = function()
			vim.opt.termguicolors = true -- Activate terminal colors.
			vim.opt.background = "dark" -- Global theme.
			vim.g.gruvbox_material_background = "hard" -- Either "hard", "medium" or "soft".
			vim.g.gruvbox_material_better_performance = 1
			vim.cmd("colorscheme gruvbox-material")
		end,
	},
	-- Nice colorschemes.
	{
		"catppuccin/nvim",
		enabled = false,
		lazy = false,
		priority = 1000,
		dependencies = { "bluz71/nvim-linefly", "shaun-mathew/Chameleon.nvim" },
		config = function()
			require("catppuccin").setup({
				flavour = "mocha", -- latte, frappe, macchiato, mocha
				background = {
					-- :h background
					light = "latte",
					dark = "mocha",
				},
				transparent_background = false,
				show_end_of_buffer = false, -- show the '~' characters after the end of buffers
				term_colors = false,
				dim_inactive = {
					enabled = false,
					shade = "dark",
					percentage = 0.15,
				},
				no_italic = false, -- Force no italic
				no_bold = false, -- Force no bold
				styles = {
					comments = { "italic" },
					conditionals = { "italic" },
					loops = {},
					functions = {},
					keywords = {},
					strings = {},
					variables = {},
					numbers = {},
					booleans = {},
					properties = {},
					types = {},
					operators = {},
				},
				color_overrides = {},
				custom_highlights = {},
				integrations = {
					cmp = true,
					dap = { enabled = true, enable_ui = true },
					fidget = true,
					gitsigns = true,
					leap = true,
					markdown = true,
					mason = true,
					native_lsp = { enabled = true },
					nvimtree = true,
					telescope = true,
					treesitter = true,
					which_key = true,
				},
			})

			vim.opt.background = "dark" -- Global theme.
			vim.cmd.colorscheme("catppuccin")
		end,
	},
	-- GitHub theme.
	{
		"projekt0n/github-nvim-theme",
		enabled = false,
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require("github-theme").setup({
				groups = {
					github_dark_tritanopia = {
						PmenuSbar = { fg = "white" },
					},
				},
			})

			vim.cmd("colorscheme github_dark_tritanopia")
		end,
	},
	-- Dark green theme.
	{
		"ribru17/bamboo.nvim",
		enabled = false,
		lazy = false,
		priority = 1000,
		config = function()
			require("bamboo").setup()
			require("bamboo").load()
		end,
	},
	-- Nord theme.
	{
		"AlexvZyl/nordic.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("nordic").load()
		end,
	},
}
