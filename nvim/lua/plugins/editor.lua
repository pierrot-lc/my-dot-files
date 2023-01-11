return {
	-- Comment lines and block of code.
	{
		"numToStr/Comment.nvim",
		config = true,
		lazy = false,
	},
	-- Toggle terminals.
	{
		"akinsho/toggleterm.nvim",
		lazy = true,
		opts = {
			open_mapping = "<C-g>",
			direction = "float",
			shade_terminals = true,
		},
		keys = { "<C-g>" },
	},
	-- File explorer.
	{
		"nvim-tree/nvim-tree.lua",
		keys = {
			{ "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Open/close file explorer" },
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
		dependencies = {
			"nvim-tree/nvim-web-devicons", -- File icons.
		},
	},
	-- Autopairs.
	{
		"windwp/nvim-autopairs",
		config = true,
		lazy = false,
	},
	-- More info when inspecting a character.
	{
		"tpope/vim-characterize",
	},
	-- Restore cursor to previous place.
	{
		"farmergreg/vim-lastplace",
	},
	-- Fuzzy finder.
	{
		"nvim-telescope/telescope.nvim",
		keys = {
			{ "<leader>f", "<cmd>Telescope find_files<cr>", desc = "Find files" },
		},
		cmd = "Telescope",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-fzf-native.nvim",
		},
		config = function()
			require("telescope").setup({
				extensions = {
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						ovveride_file_sorter = true,
						case_mode = "smart_case",
					},
				},
			})
			require("telescope").load_extension("fzf")
		end,
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
		lazy = true,
	},
}
