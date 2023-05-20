return {
	-- Find and open files.
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		keys = {
			{ "<leader>f", "<Cmd>Telescope find_files<Cr>", desc = "Find files" },
			{ "<leader>tf", "<Cmd>Telescope find_files<Cr>", desc = "Find files" },
			{ "<leader>tg", "<Cmd>Telescope live_grep<Cr>", desc = "Live grep" }, -- Requires `ripgrep` to be installed.
			{ "<leader>tb", "<Cmd>Telescope buffers<Cr>", desc = "Buffers" },
			{ "<leader>tt", "<Cmd>Telescope treesitter<Cr>", desc = "Treesitter symbols" }, -- Requires `treesitter`.
			{ "<leader>th", "<Cmd>Telescope help_tags<Cr>", desc = "Help tags" },
			{ "<leader>ts", "<Cmd>Telescope lsp_document_symbols<Cr>", desc = "Document symbols" },
			{ "<leader>tc", "<Cmd>Telescope commands<Cr>", desc = "Commands" },
			{ "<leader>tm", "<Cmd>Telescope marks<Cr>", desc = "Marks" },
			{ "<Leader>tp", "<Cmd>Telescope resume<Cr>", desc = "Resume last search" },
			{ "<leader>mp", "<Cmd>Telescope planets<Cr>", desc = "Use the telescope" },
		},
		dependencies = {
			"nvim-lua/plenary.nvim", -- Common lua functions.
			"nvim-telescope/telescope-fzf-native.nvim",
			"tsakirist/telescope-lazy.nvim",
			"nvim-treesitter/nvim-treesitter",
			"dhruvmanila/browser-bookmarks.nvim",
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
				},
			})
			require("telescope").load_extension("fzf") -- telescope-fzf-native.nvim
			require("telescope").load_extension("lazy") -- telescope-lazy.nvim
			require("telescope").load_extension("bookmarks") -- browser-bookmarks.nvim
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
		cmd = "Telescope",
		keys = { { "<Leader>tl", "<Cmd>Telescope lazy<Cr>", desc = "Lazy plugins" } },
		dependencies = {
			"folke/lazy.nvim",
		},
	},
	-- Quickly browse some predefined websites.
	{
		"lalitmee/browse.nvim",
		cmd = "Browse",
		keys = {
			{ "<Leader>ts", "<Cmd>Browse<Cr>", desc = "Show all browsing options" },
			{ "<Leader>to", "<Cmd>BrowseBookmarks<Cr>", desc = "Search among bookmarks" },
			{ "<Leader>i", "<Cmd>BrowseInputSearch<Cr>", desc = "Search the internet" },
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
		cmd = "Telescope",
		keys = { { "<Leader>td", "<Cmd>Telescope bookmarks<Cr>", desc = "Browser bookmarks" } },
		dependencies = {
			"kkharji/sqlite.lua", -- For firefox support, install `sqlite` and `sqlite-dev`.
		},
		opts = {
			selected_browser = "firefox",
			profile_name = "default-release",
			url_open_command = "xdg-open",
		},
	},
}
