return {
	-- Main LSP package.
	{
		"neovim/nvim-lspconfig",
		event = "BufReadPre",
		keys = {
			{ "gl",         "<Cmd>lua vim.diagnostic.open_float(nil, {focus=false})<Cr>", desc = "Show diagnostics" },
			{ "gd",         "<Cmd>lua vim.lsp.buf.definition()<Cr>",                      desc = "Go to definition" },
			{ "<Leader>La", "<Cmd>lua vim.lsp.buf.code_action()<Cr>",                     desc = "Show code action" },
		},
		dependencies = {
			"williamboman/mason.nvim",
			{ "williamboman/mason-lspconfig.nvim", opts = { automatic_installation = true } }, -- Make it easier to use `mason` with `lspconfig`.
			{ "folke/neodev.nvim",                 config = true },                         -- Add neovim library support for `sumneko_lua`.
			"ray-x/lsp_signature.nvim",                                                     -- Show function signatures.
		},
		config = function()
			local lspconfig = require("lspconfig")

			-- Load LSP servers.
			lspconfig["pyright"].setup({})
			lspconfig["lua_ls"].setup({})
			lspconfig["marksman"].setup({})
			lspconfig["rust_analyzer"].setup({})

			-- Bind the `lsp_signature` to those LSP servers.
			require("lsp_signature").setup({ bind = true, handler_opts = { border = "rounded" } })

			-- Toggle diagnostics.
			local show_diagnostic = true
			vim.keymap.set("n", "<leader>Ld", function()
				if not show_diagnostic then
					vim.diagnostic.enable()
					print("Diagnostics showed.")
				else
					vim.diagnostic.disable()
					print("Diagnostics hidden.")
				end
				show_diagnostic = not show_diagnostic
			end, { desc = "Toggle diagnostics" })
		end,
	},
	-- Hook code actions, diagnostics, formatting, completion...
	{
		"jose-elias-alvarez/null-ls.nvim",
		event = "BufReadPre",
		keys = {
			{ "<leader>Pn", "<CMD>NullLsInfo<CR>", desc = "Null-ls" },
		},
		dependencies = {
			"williamboman/mason.nvim",
		},
		config = function()
			local null_ls = require("null-ls")
			local sources = {
				-- General.
				null_ls.builtins.diagnostics.codespell,
				null_ls.builtins.code_actions.proselint,
				null_ls.builtins.diagnostics.proselint,
				-- Python.
				null_ls.builtins.formatting.black,
				null_ls.builtins.diagnostics.flake8.with({
					extra_args = { "--max-line-length=88", "--extend-ignore=E203" }, -- Black configuration.
				}),
				null_ls.builtins.formatting.isort.with({
					extra_args = { "--profile=black" }, -- Black configuration.
				}),
				-- Lua.
				null_ls.builtins.formatting.stylua,
				-- Shell.
				null_ls.builtins.code_actions.shellcheck,
				null_ls.builtins.diagnostics.shellcheck,
				null_ls.builtins.formatting.beautysh,
				-- Markdown.
				null_ls.builtins.diagnostics.markdownlint,
				null_ls.builtins.formatting.markdownlint,
				-- JSON & YAML.
				null_ls.builtins.formatting.jq,
				null_ls.builtins.formatting.yamlfmt,
				null_ls.builtins.diagnostics.yamllint,
			}

			null_ls.setup({
				sources = sources,
			})

			-- Update diagnostics even in insert mode. Can slow nvim.
			vim.diagnostic.config({ update_in_insert = false })
		end,
	},
	-- Install LSP packages.
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		keys = {
			{ "<leader>Pm", "<cmd>Mason<cr>", desc = "Mason" },
		},
		config = true,
	},
	-- Automatically install Null-ls sources using Mason.
	{
		"jay-babu/mason-null-ls.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"jose-elias-alvarez/null-ls.nvim",
		},
		opts = { automatic_installation = true },
	},
	-- Show a tree-like view of file symbols.
	{
		"simrat39/symbols-outline.nvim",
		cmd = "SymbolsOutline",
		keys = {
			{ "<Leader>Lo", "<Cmd>SymbolsOutline<Cr>", desc = "Show symbols outline" },
		},
		config = true,
	},
	-- Eye candy nvim-lsp progress.
	{
		"j-hui/fidget.nvim",
		dependencies = "neovim/nvim-lspconfig",
		opts = {
			window = { blend = 0 },
		},
	},
}
