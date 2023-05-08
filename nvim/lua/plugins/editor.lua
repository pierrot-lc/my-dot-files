return {
	-- Move quickly anywhere in the visible editor area.
	{
		"ggandor/leap.nvim",
		keys = {
			{
				"<Leader>s",
				"<Cmd>lua require('leap').leap({ target_windows = { vim.fn.win_getid() } })<Cr>",
				desc = "Leap",
			},
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
					augend.integer.alias.decimal,
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
		config = function()
			local function on_attach(bufnr)
				local api = require("nvim-tree.api")

				api.config.mappings.default_on_attach(bufnr)

				vim.keymap.set(
					"n",
					"l",
					api.node.open.edit,
					{ desc = "Open", buffer = bufnr, noremap = true, silent = true, nowait = true }
				)
			end

			require("nvim-tree").setup({
				on_attach = on_attach,
			})
		end,
	},
	-- `Ranger` integration.
	{
		"kelly-lin/ranger.nvim",
		keys = {
			{ "<Leader>r", "<Cmd>lua require('ranger-nvim').open()<CR>", desc = "Open ranger" },
		},
		lazy = false, -- Unfortunately there's no easy way to load this plugin when entering a directory.
		opts = { replace_netrw = true },
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
	-- Better json and yaml support.
	{
		"gennaro-tedesco/nvim-jqx",
		ft = { "json", "yaml" },
	},
	-- Better "w", "e", "b" moves.
	{
		"chrisgrieser/nvim-spider",
		keys = {
			{ "w", "<Cmd> lua require('spider').motion('w')<CR>", desc = "Spider-w" },
			{ "e", "<Cmd> lua require('spider').motion('e')<CR>", desc = "Spider-e" },
			{ "b", "<Cmd> lua require('spider').motion('b')<CR>", desc = "Spider-b" },
			{ "ge", "<Cmd> lua require('spider').motion('ge')<CR>", desc = "Spider-ge" },
		},
	},
	-- Provide default gitignores.
	{
		"wintermute-cell/gitignore.nvim",
		cmd = "Gitignore",
		dependencies = { "nvim-telescope/telescope.nvim" },
	},
	-- Multiple search and replace with ease.
	{
		"AckslD/muren.nvim",
		cmd = {
			"MurenToggle",
			"MurenOpen",
			"MurenClose",
			"MurenFresh",
			"MurenUnique",
		},
		config = true,
	},
}
