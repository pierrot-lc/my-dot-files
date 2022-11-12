-- ========================================================================== --
-- ==                               PLUGINS                                == --
-- ========================================================================== --
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local install_plugins = false

-- Automatic install
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	print("Installing packer...")
	local packer_url = "https://github.com/wbthomason/packer.nvim"
	vim.fn.system({ "git", "clone", "--depth", "1", packer_url, install_path })
	print("Done.")

	vim.cmd("packadd packer.nvim")
	install_plugins = true
end

require("packer").startup(function(use)
	use("wbthomason/packer.nvim") -- Plugins manager.
	use("nvim-lua/plenary.nvim") -- Required by a lot of other plugins.
	-- use("joshdick/onedark.vim") -- Theme inspired by Atom.
	-- use("ellisonleao/gruvbox.nvim") --Classic vim theme.
	use("sainnhe/gruvbox-material") -- Classic vim theme.
	use("nvim-lualine/lualine.nvim") -- Good looking status line.
	use("akinsho/toggleterm.nvim") -- Enable NeoVim terminal emulator.
	use("numToStr/Comment.nvim") -- Comments management.
	use("lewis6991/gitsigns.nvim") -- Show git status.
	use("folke/which-key.nvim") -- Show keybindings descriptions.
	use("windwp/nvim-autopairs") -- Smart autopairs.
	use("nvim-tree/nvim-tree.lua") -- File explorer.
	use("nvim-tree/nvim-web-devicons") -- File icons.
	use("goolord/alpha-nvim") -- Startup screen.
	use("nvim-telescope/telescope.nvim") -- Find and filter files.
	use({
		"nvim-telescope/telescope-fzf-native.nvim",
		run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
	})

	-- Treesitter, analyze and create an abstract syntax tree.
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function() -- Make sure that all parsers are up to date.
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
	})
	-- use("nvim-treesitter/nvim-treesitter-textobjects")

	-- Debug Adapter Protocol
	use("mfussenegger/nvim-dap") -- DAP client.
	use("rcarriga/nvim-dap-ui") -- UI for the DAP client.
	use("mfussenegger/nvim-dap-python") -- Python config for the DAP client.

	-- LSP plugins.
	use("neovim/nvim-lspconfig")
	use("williamboman/mason.nvim") -- Manage LSP, linters, formatters...
	use("williamboman/mason-lspconfig.nvim") -- Download and handle LSP servers.
	use("jose-elias-alvarez/null-ls.nvim") -- Hook code actions, diagnostics, formatting, completion...
	use("folke/neodev.nvim") -- Provide completion for the lua vim library.

	-- Completion plugins.
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-nvim-lsp")
	use("ray-x/lsp_signature.nvim")

	-- Snippet plugins.
	use("L3MON4D3/LuaSnip")
	use("saadparwaiz1/cmp_luasnip")
	use("rafamadriz/friendly-snippets")

	if install_plugins then
		require("packer").sync()
	end
end)

if install_plugins then
	-- We just installed packer for the first time, we stop here
	-- to avoid loading inexistent packages.
	print("==================================")
	print("    Plugins are being installed")
	print("    Wait until Packer completes,")
	print("       then restart nvim")
	print("==================================")
	return
end

-- ========================================================================== --
-- ==                         PLUGINS CONFIGURATION                        == --
-- ========================================================================== --
require("Comment").setup()
require("gitsigns").setup()
require("which-key").setup()
require("nvim-autopairs").setup()
require("alpha").setup(require("alpha.themes.startify").config)
require("toggleterm").setup({
	open_mapping = "<C-g>",
	direction = "float", -- Either "float", "horizontal" or "vertical"
	shade_terminals = true,
})
require("telescope").setup({
	extensions = {
		fzf = {
			fuzzy = true, -- False will only do exact matching
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case", -- Either "smart_case","ignore_case" or "respect_case"
		},
	},
})
require("telescope").load_extension("fzf")

require("nvim-tree").setup({
	view = {
		mappings = {
			list = {
				{ key = "l", action = "edit" },
			},
		},
	},
})

-- Set colorscheme defaults (order is important here).
vim.opt.termguicolors = true -- Activate terminal colors
vim.opt.background = "dark" -- Global theme
vim.g.gruvbox_material_background = "hard"
vim.g.gruvbox_material_better_performance = 1
vim.cmd("colorscheme gruvbox-material") -- Select theme

require("lualine").setup({
	options = {
		theme = "gruvbox-material",
		icons_enabled = true,
	},
})
vim.opt.showmode = false -- We remove this as this is already shown by the lualine

-- Treesitter configuration.
-- It has 3 main modules: highlight, incremental_selection and indent.
require("nvim-treesitter.configs").setup({
	highlight = { enable = true },
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "gnn", -- In normal mode.
			node_incremental = "grn", -- In visual mode.
			scope_incremental = "grc", -- In visual mode.
			node_decremental = "grm", -- In visual mode.
		},
	},
	indent = {
		enable = true,
		disable = { "python" },
	},
	ensure_installed = {
		"json",
		"lua",
		"python",
	},
})

-- DAP configuration.
local dap, dapui = require("dap"), require("dapui")
require("dap-python").setup()
dapui.setup()
-- Automatically open and close UI when launching DAP.
dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open({})
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close({})
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close({})
end

-- LSP & completion configurations (in another file).
require("lsp_configuration")
