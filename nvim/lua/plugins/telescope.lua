return {
	-- Find and open files.
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		keys = {
			{ "<Leader>f",  "<CMD>Telescope find_files<CR>",           desc = "Find files" },
			{ "<Leader>tf", "<CMD>Telescope find_files<CR>",           desc = "Find files" },
			{ "<Leader>tg", "<CMD>Telescope live_grep<CR>",            desc = "Live grep" }, -- Requires `ripgrep` to be installed.
			{ "<Leader>tb", "<CMD>Telescope buffers<CR>",              desc = "Buffers" },
			{ "<Leader>tt", "<CMD>Telescope treesitter<CR>",           desc = "Treesitter symbols" }, -- Requires `treesitter`.
			{ "<Leader>th", "<CMD>Telescope help_tags<CR>",            desc = "Help tags" },
			{ "<Leader>ts", "<CMD>Telescope lsp_document_symbols<CR>", desc = "Document symbols" },
			{ "<Leader>tc", "<CMD>Telescope commands<CR>",             desc = "Commands" },
			{ "<Leader>tm", "<CMD>Telescope marks<CR>",                desc = "Marks" },
			{ "<Leader>tp", "<CMD>Telescope resume<CR>",               desc = "Resume last search" },
		},
		dependencies = {
			"nvim-lua/plenary.nvim", -- Common lua functions.
			"nvim-telescope/telescope-fzf-native.nvim",
			"tsakirist/telescope-lazy.nvim",
			"nvim-treesitter/nvim-treesitter",
			"cljoly/telescope-repo.nvim",
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
					repo = {
						list = {
							file_ignore_patterns = { "/%.cache/", "/%.cargo/", "/share/" },
						},
					},
				},
			})
			require("telescope").load_extension("fzf") -- telescope-fzf-native.nvim
			require("telescope").load_extension("lazy") -- telescope-lazy.nvim
			require("telescope").load_extension("repo") -- telescope-repo.nvim
		end,
	},
	-- Fuzzy finder for `telescope.nvim`.
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		lazy = true,
		build = "make",
	},
	-- Telescope plugins installed by `lazy.nvim`.
	{
		"tsakirist/telescope-lazy.nvim",
		keys = { { "<Leader>tl", "<CMD>Telescope lazy<CR>", desc = "Lazy plugins" } },
		dependencies = {
			"folke/lazy.nvim",
		},
	},
	-- Browse local repositories (needs `locate` and `fd`).
	{
		"cljoly/telescope-repo.nvim",
		keys = {
			{ "<Leader>tr", "<CMD>Telescope repo list<CR>", desc = "Browse repositories" },
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
}
