return {
	-- Find and open files.
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		keys = {
			{ "<Leader>f", "<CMD>Telescope find_files<CR>", desc = "Find files" },
			{ "<Leader>tf", "<CMD>Telescope find_files<CR>", desc = "Find files" },
			{ "<Leader>tg", "<CMD>Telescope live_grep<CR>", desc = "Live grep" }, -- Requires `ripgrep` to be installed.
			{ "<Leader>tb", "<CMD>Telescope buffers<CR>", desc = "Buffers" },
			{ "<Leader>tt", "<CMD>Telescope treesitter<CR>", desc = "Treesitter symbols" }, -- Requires `treesitter`.
			{ "<Leader>th", "<CMD>Telescope help_tags<CR>", desc = "Help tags" },
			{ "<Leader>ts", "<CMD>Telescope lsp_document_symbols<CR>", desc = "Document symbols" },
			{ "<Leader>tc", "<CMD>Telescope commands<CR>", desc = "Commands" },
			{ "<Leader>tm", "<CMD>Telescope marks<CR>", desc = "Marks" },
			{ "<Leader>tp", "<CMD>Telescope resume<CR>", desc = "Resume last search" },
			{ "<Leader>mp", "<CMD>Telescope planets<CR>", desc = "Use the telescope" },
		},
		dependencies = {
			"nvim-lua/plenary.nvim", -- Common lua functions.
			"nvim-telescope/telescope-fzf-native.nvim",
			"tsakirist/telescope-lazy.nvim",
			"nvim-treesitter/nvim-treesitter",
			"dhruvmanila/browser-bookmarks.nvim",
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
					bookmarks = {
						selected_browser = "firefox",
						profile_name = "default-release",
						url_open_command = "xdg-open",
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
			require("telescope").load_extension("bookmarks") -- browser-bookmarks.nvim
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
	-- Quickly browse some predefined websites.
	{
		"lalitmee/browse.nvim",
		cmd = "Browse",
		keys = {
			{ "<Leader>ts", "<CMD>Browse<CR>", desc = "Show all browsing options" },
			{ "<Leader>to", "<CMD>BrowseBookmarks<CR>", desc = "Search among bookmarks" },
			{ "<Leader>i", "<CMD>BrowseInputSearch<CR>", desc = "Search the internet" },
		},
		dependencies = { "nvim-telescope/telescope.nvim" },
		config = function()
			local browse = require("browse")
			local bookmarks = {
				["GitHub"] = {
					["name"] = "Search GitHub from neovim",
					["Code search"] = "https://github.com/search?q=%s&type=code",
					["Repo search"] = "https://github.com/search?q=%s&type=repositories",
					["Issues search"] = "https://github.com/search?q=%s&type=issues",
					["Pulls search"] = "https://github.com/search?q=%s&type=pullrequests",
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
	-- Browse my browser bookmarks.
	{
		"dhruvmanila/browser-bookmarks.nvim",
		keys = { { "<Leader>td", "<CMD>Telescope bookmarks<CR>", desc = "Browser bookmarks" } },
		dependencies = {
			"kkharji/sqlite.lua", -- For firefox support, install `sqlite` and `sqlite-dev`.
		},
		opts = {
			selected_browser = "firefox",
			profile_name = "default-release",
			url_open_command = "xdg-open",
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
