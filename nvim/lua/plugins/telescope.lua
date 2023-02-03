return {
	-- Find and open files.
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		keys = {
			{ "<leader>f", "<Cmd>Telescope find_files<Cr>", desc = "Find files" },
			{ "<leader>Tf", "<Cmd>Telescope find_files<Cr>", desc = "Find files" },
			{ "<leader>Tg", "<Cmd>Telescope live_grep<Cr>", desc = "Live grep" }, -- Requires `ripgrep` to be installed.
			{ "<leader>Tb", "<Cmd>Telescope buffers<Cr>", desc = "Buffers" },
			{ "<leader>Tt", "<Cmd>Telescope treesitter<Cr>", desc = "Treesitter symbols" }, -- Requires `treesitter`.
			{ "<leader>Th", "<Cmd>Telescope help_tags<Cr>", desc = "Help tags" },
			{ "<leader>Tr", "<Cmd>Telescope lsp_references<Cr>", desc = "References of the word under cursor" },
			{ "<leader>Mp", "<Cmd>Telescope planets<Cr>", desc = "Use the telescope" },
		},
		dependencies = {
			"nvim-lua/plenary.nvim", -- Common lua functions.
			"nvim-telescope/telescope-fzf-native.nvim",
			"tsakirist/telescope-lazy.nvim",
			"nvim-treesitter/nvim-treesitter",
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
			require("telescope").load_extension("fzf") -- telescope-fzf-native.nvim
			require("telescope").load_extension("lazy") -- telescope-lazy.nvim
		end,
	},
	-- Fuzzy finder for `telescope.nvim`.
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		lazy = true,
		build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
	},
	-- Telescope plugins installed by `lazy.nvim`.
	{
		"tsakirist/telescope-lazy.nvim",
		cmd = "Telescope",
		keys = { { "<Leader>Tl", "<Cmd>Telescope lazy<Cr>", desc = "Lazy plugins" } },
		dependencies = {
			"folke/lazy.nvim",
		},
	},
}
