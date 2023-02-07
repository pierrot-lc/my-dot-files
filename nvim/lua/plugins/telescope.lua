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
	-- Quickly browse some predefined websites.
	{
		"lalitmee/browse.nvim",
		cmd = "Browse",
		keys = {
			{ "<Leader>Ts", "<Cmd>Browse<Cr>", desc = "Show all browsing options" },
			{ "<Leader>To", "<Cmd>BrowseBookmarks<Cr>", desc = "Search among bookmarks" },
			{ "<Leader>i", "<Cmd>BrowseInputSearch<Cr>", desc = "Search the internet" },
		},
		dependencies = { "nvim-telescope/telescope.nvim" },
		config = function()
			local browse = require("browse")
			local bookmarks = {
				["github"] = {
					["name"] = "search github from neovim",
					["code_search"] = "https://github.com/search?q=%s&type=code",
					["repo_search"] = "https://github.com/search?q=%s&type=repositories",
					["issues_search"] = "https://github.com/search?q=%s&type=issues",
					["pulls_search"] = "https://github.com/search?q=%s&type=pullrequests",
				},
			}

			browse.setup({
				provider = "duckduckgo",
				bookmarks = bookmarks,
			})

			-- Add some commands.
			vim.api.nvim_create_user_command("Browse", function()
				browse.browse()
			end, { desc = "Show all browsing options" })
			vim.api.nvim_create_user_command("BrowseBookmarks", function()
				browse.open_bookmarks()
			end, { desc = "Browse bookmarks" })
			vim.api.nvim_create_user_command("BrowseInputSearch", function()
				browse.input_search()
			end, { desc = "Browse the general web" })
		end,
	},
}
