return {
	-- Main LSP package.
	{
		"neovim/nvim-lspconfig",
		event = "BufReadPre",
		keys = {
			{ "gl", "<CMD>lua vim.diagnostic.open_float(nil, {focus=false})<CR>", desc = "Show diagnostics" },
			{ "gd", "<CMD>lua vim.lsp.buf.definition()<CR>", desc = "Go to definition" },
			{ "gs", "<CMD>lua vim.lsp.buf.signature_help()<CR>", desc = "Show signature help" },
			{ "gr", "<CMD>lua vim.lsp.buf.rename()<CR>", desc = "Rename symbol" },
			{ "<Leader>la", "<CMD>lua vim.lsp.buf.code_action()<CR>", desc = "Show code action" },
		},
		dependencies = {
			{ "folke/neodev.nvim", config = true }, -- Add neovim library support for `sumneko_lua`.
			"ray-x/lsp_signature.nvim", -- Show function signatures.
		},
		config = function()
			local lspconfig = require("lspconfig")

			-- Load LSP servers.
			lspconfig["pylsp"].setup({
				settings = {
					pylsp = {
						plugins = {
							preload = { enabled = true },
							autopep8 = { enabled = false },
							flake8 = { enabled = false },
							pycodestyle = { enabled = false },
							pydocstyle = { enabled = false },
							mccabe = { enabled = false },
							yapf = { enabled = false },
							pylint = { enabled = false },
							pyflakes = { enabled = false },
						},
					},
				},
			})
			lspconfig["ruff_lsp"].setup({
				init_options = {
					settings = {
						args = { "--ignore", "E501" },
					},
				},
			})
			lspconfig["lua_ls"].setup({
				settings = {
					Lua = {
						runtime = {
							-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
							version = "LuaJIT",
						},
						diagnostics = {
							-- Get the language server to recognize the `vim` global
							globals = { "vim" },
						},
						workspace = {
							-- Make the server aware of Neovim runtime files
							library = vim.api.nvim_get_runtime_file("", true),
						},
						telemetry = {
							enable = true, -- That's fine.
						},
						format = {
							enable = false,
						},
					},
				},
			})
			lspconfig["bashls"].setup({})
			lspconfig["marksman"].setup({})
			lspconfig["ltex"].setup({})

			-- Bind the `lsp_signature` to those LSP servers.
			local signature_opts = {
				bind = true,
				floating_window = true,
				handler_opts = { border = "rounded" },
				hint_enable = false,
				wrap = false,
				hi_parameter = "Search",
			}
			require("lsp_signature").setup(signature_opts)

			vim.api.nvim_create_user_command(
				"LspSignatureFloatingWindow",
				require("lsp_signature").toggle_float_win,
				{ desc = "Toggle floating window" }
			)

			-- Toggle diagnostics.
			local show_diagnostics = true
			local toggle_diagnostics = function()
				show_diagnostics = not show_diagnostics
				if show_diagnostics then
					vim.diagnostic.enable()
					print("Diagnostics activated.")
				else
					vim.diagnostic.disable()
					print("Diagnostics hidden.")
				end
			end
			vim.keymap.set("n", "<Leader>ld", toggle_diagnostics, { desc = "Toggle diagnostics" })
		end,
	},
	-- Linter, complementary to the native LSP.
	{
		"mfussenegger/nvim-lint",
		event = "BufReadPre",
		config = function()
			require("lint").linters_by_ft = {
				markdown = { "markdownlint", "codespell", "proselint" },
				norg = { "codespell", "proselint" },
				sh = { "shellcheck" },
				yaml = { "yamllint" },
			}

			vim.diagnostic.config({ update_in_insert = false })

			vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
				callback = function()
					require("lint").try_lint()
				end,
			})
		end,
	},
	-- Implement formatters.
	{
		"stevearc/conform.nvim",
		keys = {
			{ "<Leader>F", "<CMD>lua require('conform').format()<CR>", desc = "Format whole buffer" },
		},
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "isort", "black" },
				sh = { "shfmt" },
				json = { "jq" },
				latex = { "latexindent" },
			},
		},
	},
	-- Eye candy nvim-lsp progress.
	{
		"j-hui/fidget.nvim",
		tag = "legacy",
		dependencies = "neovim/nvim-lspconfig",
		opts = {
			window = { blend = 0 },
		},
	},
}
