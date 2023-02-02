return {
	-- Move quickly anywhere in the visible editor area.
	{
		"ggandor/leap.nvim",
		keys = {
			{ "<leader>s", "<Plug>(leap-forward-to)", desc = "Search forward" },
			{ "<leader>S", "<Plug>(leap-backward-to)", desc = "Search backward" },
		},
	},
	-- Better increment/decrement features.
	{
		"monaqa/dial.nvim",
		keys = {
			{ "<C-a>", desc = "Increment" },
			{ "<C-x>", desc = "Decrement" },
		},
		config = function()
			local augend = require("dial.augend")
			require("dial.config").augends:register_group({
				default = {
					augend.integer.alias.decimal_int,
					augend.integer.alias.hex,
					augend.date.alias["%Y/%m/%d"],
					augend.constant.alias.alpha,
					augend.constant.alias.Alpha,
					augend.constant.alias.bool,
					augend.constant.new({ elements = { "True", "False" } }),
				},
			})

			vim.api.nvim_set_keymap("n", "<C-a>", require("dial.map").inc_normal(), { noremap = true })
			vim.api.nvim_set_keymap("n", "<C-x>", require("dial.map").dec_normal(), { noremap = true })
		end,
	},
	-- Comment lines and block of code.
	{
		"numToStr/Comment.nvim",
		event = "VeryLazy",
		config = true,
	},
	-- Toggle terminals.
	{
		"akinsho/toggleterm.nvim",
		keys = { "<C-g>", desc = "Toggle the terminal" },
		opts = {
			open_mapping = "<C-g>",
			direction = "float",
			shade_terminals = true,
		},
	},
	-- File explorer.
	{
		"nvim-tree/nvim-tree.lua",
		keys = {
			{ "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Open/close file explorer" },
		},
		dependencies = {
			"nvim-tree/nvim-web-devicons", -- File icons.
		},
		opts = {
			view = {
				mappings = {
					list = {
						{ key = "l", action = "edit" },
					},
				},
			},
		},
	},
	-- Autopairs.
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
	-- More info when inspecting a character.
	{
		"tpope/vim-characterize",
		keys = {
			{ "ga", desc = "Show character infos" },
		},
	},
	-- Restore cursor to previous place.
	{
		"farmergreg/vim-lastplace",
	},
}
