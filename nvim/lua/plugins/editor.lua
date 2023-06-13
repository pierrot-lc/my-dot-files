return {
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
		"echasnovski/mini.comment",
		keys = {
			{ "gc",  desc = "Comment line (visual mode)", mode = "v" },
			{ "gcc", desc = "Comment line" },
			{ "dgc", desc = "Delete comment textobject" },
			{ "vgc", desc = "Select comment textobject" },
		},
		opts = {
			mappings = {
				comment = "gc",
				comment_line = "gcc",
				textobject = "gc",
			},
		},
	},
	-- Toggle a virtual terminal.
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
				update_cwd = true,
				update_focused_file = {
					enable = true,
					update_cwd = true,
				},
			})
		end,
	},
	-- `Ranger` integration.
	-- `pipx install ranger-fm`
	{
		"kelly-lin/ranger.nvim",
		keys = {
			{ "<Leader>r", "<CMD>lua require('ranger-nvim').open()<CR>", desc = "Open ranger" },
		}, -- Unfortunately there's no easy way to load this plugin when entering a directory.
		opts = { replace_netrw = true },
	},
	-- Autopairs.
	{
		"echasnovski/mini.pairs",
		event = "InsertEnter",
		config = true,
	},
	-- Easy splits and joins.
	{
		"echasnovski/mini.splitjoin",
		keys = {
			{ "gS", desc = "Toggle split/join" },
		},
		opts = {
			mappings = {
				toggle = "gS",
			},
		},
	},
	-- More info when inspecting a character.
	{
		"tpope/vim-characterize",
		keys = {
			{ "ga", desc = "Show character infos" },
		},
	},
	-- Highlight and search for todo comments like TODO, HACK or BUG.
	{
		"folke/todo-comments.nvim",
		cmd = { "TodoTelescope" },
		event = "BufReadPre",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = true,
	},
}
