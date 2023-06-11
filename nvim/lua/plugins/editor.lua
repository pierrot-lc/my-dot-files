return {
	-- Move quickly anywhere in the visible editor area.
	{
		"ggandor/leap.nvim",
		keys = {
			{
				"<Leader>s",
				"<CMD>lua require('leap').leap({ target_windows = { vim.fn.win_getid() } })<CR>",
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
		keys = {
			{ "gcc", desc = "Comment line" },
			{ "gbc", desc = "Comment block" },
			{ "gc", desc = "Comment line (visual mode)", mode = "v" },
			{ "gb", desc = "Comment block (visual mode)", mode = "v" },
			{ "gcO", desc = "Comment above" },
			{ "gco", desc = "Comment below" },
			{ "gcA", desc = "Comment at the end of line" },
		},
		config = function()
			require("Comment").setup({
				toggler = {
					line = "gcc",
					block = "gbc",
				},
				opleader = {
					line = nil,
					block = nil,
				},
			})

			-- Check for the "which-key" plugin.
			local has_whichkey, whichkey = pcall(require, "which-key")
			if has_whichkey then
				whichkey.register({
					["g"] = {
						c = {
							name = "+Comment",
							c = "Line",
							b = "Block",
							O = "Above",
							o = "Below",
							A = "At the end of line",
						},
					},
				})
			end
		end,
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
	-- Automatically change the project working directory when opening a new file.
	{
		"notjedi/nvim-rooter.lua",
		cmd = { "Rooter", "RooterToggle" },
		opts = {
			manual = true,
		},
	},
	-- File explorer.
	{
		"nvim-tree/nvim-tree.lua",
		keys = {
			{ "<Leader>e", "<CMD>NvimTreeToggle<CR>", desc = "Open/close file explorer" },
		},
		dependencies = {
			"nvim-tree/nvim-web-devicons", -- File icons.
			"notjedi/nvim-rooter.lua",
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
			{ "<Leader>r", "<CMD>lua require('ranger-nvim').open()<CR>", desc = "Open ranger" },
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
			{ "w", "<CMD> lua require('spider').motion('w')<CR>", desc = "Spider-w" },
			{ "e", "<CMD> lua require('spider').motion('e')<CR>", desc = "Spider-e" },
			{ "b", "<CMD> lua require('spider').motion('b')<CR>", desc = "Spider-b" },
			{ "ge", "<CMD> lua require('spider').motion('ge')<CR>", desc = "Spider-ge" },
		},
	},
}
