return {
	-- Main LSP package.
	{
		"neovim/nvim-lspconfig",
		event = "BufReadPre",
		dependencies = {
			"williamboman/mason.nvim",
			{ "williamboman/mason-lspconfig.nvim", opts = { automatic_installation = true } }, -- Make it easier to use `mason` with `lspconfig`.
			{ "folke/neodev.nvim", config = true }, -- Add neovim library support for `sumneko_lua`.
			"ray-x/lsp_signature.nvim", -- Show function signatures.
		},
		config = function()
			local lspconfig = require("lspconfig")

			-- Load LSP servers.
			lspconfig["pyright"].setup({})
			lspconfig["sumneko_lua"].setup({})
			lspconfig["marksman"].setup({})
			lspconfig["rust_analyzer"].setup({})

			-- Bind the `lsp_signature` to those LSP servers.
			require("lsp_signature").setup({ bind = true, handler_opts = { border = "rounded" } })
		end,
	},
	-- Hook code actions, diagnostics, formatting, completion...
	{
		"jose-elias-alvarez/null-ls.nvim",
		event = "BufReadPre",
		config = function()
			local null_ls = require("null-ls")
			local sources = {
				null_ls.builtins.diagnostics.codespell,
				null_ls.builtins.code_actions.proselint,
				null_ls.builtins.formatting.black,
				null_ls.builtins.diagnostics.flake8.with({
					extra_args = { "--max-line-length=88", "--extend-ignore=E203" }, -- Black configuration
				}),
				null_ls.builtins.formatting.isort.with({
					extra_args = { "--profile=black" }, -- Black configuration
				}),
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.code_actions.shellcheck,
				null_ls.builtins.diagnostics.shellcheck,
				null_ls.builtins.formatting.beautysh,
				null_ls.builtins.diagnostics.markdownlint,
				null_ls.builtins.formatting.markdownlint,
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
		config = true,
		keys = {
			{ "<leader>Pm", "<cmd>Mason<cr>", "Mason" },
		},
		cmd = { "Mason" },
	},
}
