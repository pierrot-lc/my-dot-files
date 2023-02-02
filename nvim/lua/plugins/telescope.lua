return {
	-- Find and open files.
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		keys = {
			{ "<leader>f", "<cmd>Telescope find_files<cr>", desc = "Find files" },
			{ "<leader>Tf", "<cmd>Telescope find_files<cr>", desc = "Find files" },
			{ "<leader>Tg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" }, -- Requires `ripgrep` to be installed.
			{ "<leader>Tb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
			{ "<leader>Th", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
			{ "<leader>Mp", "<cmd>Telescope planets<cr>", desc = "Use the telescope" },
		},
		dependencies = {
			"nvim-lua/plenary.nvim", -- Common lua functions.
			"nvim-telescope/telescope-fzf-native.nvim",
			"tsakirist/telescope-lazy.nvim",
			"sudormrfbin/cheatsheet.nvim",
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
