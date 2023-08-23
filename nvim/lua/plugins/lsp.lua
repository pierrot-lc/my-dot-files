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
			lspconfig["marksman"].setup({})

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

			-- Deactivate all LSP clients.
			local deactivate_lsp = function()
				vim.lsp.stop_client(vim.lsp.get_active_clients())
				print("LSP clients deactivated.")
			end
			vim.keymap.set("n", "<Leader>ll", deactivate_lsp, { desc = "Deactivate LSP" })

			-- Toggle signatures.
			local show_signatures = signature_opts.floating_window
			local toggle_signatures = function()
				show_signatures = not show_signatures
				require("lsp_signature").toggle_float_win()
				if show_signatures then
					print("Signatures activated.")
				else
					print("Signatures hidden.")
				end
			end
			vim.keymap.set("n", "<Leader>lp", toggle_signatures, { desc = "Toggle signature hints" })

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
				python = { "ruff" },
				yaml = { "yamllint" },
				markdown = { "markdownlint", "codespell", "proselint" },
				shell = { "shellcheck" },
				norg = { "codespell", "proselint" },
			}

			local ruff = require("lint").linters.ruff
			vim.list_extend(ruff.args, { "--ignore", "E501" })  -- Ingnore line length.

			vim.diagnostic.config({ update_in_insert = false })

			vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
				callback = function()
					require("lint").try_lint()
				end,
			})
		end,
	},
	-- -- Hook code actions, diagnostics, formatting, completion...
	-- {
	-- 	"jose-elias-alvarez/null-ls.nvim",
	-- 	event = "BufReadPre",
	-- 	keys = {
	-- 		{ "<Leader>pn", "<CMD>NullLsInfo<CR>", desc = "Null-ls" },
	-- 	},
	-- 	config = function()
	-- 		local null_ls = require("null-ls")
	-- 		local sources = {
	-- 			-- General.
	-- 			null_ls.builtins.diagnostics.codespell,
	-- 			null_ls.builtins.diagnostics.proselint,
	-- 			null_ls.builtins.code_actions.proselint,
	-- 			-- Python.
	-- 			null_ls.builtins.formatting.black,
	-- 			null_ls.builtins.formatting.isort.with({
	-- 				extra_args = { "--profile=black" }, -- Black configuration.
	-- 			}),
	-- 			null_ls.builtins.diagnostics.ruff.with({
	-- 				extra_args = { "--ignore", "E501" }, -- Ignore line length.
	-- 			}),
	-- 			-- Lua.
	-- 			null_ls.builtins.formatting.stylua,
	-- 			-- Shell.
	-- 			null_ls.builtins.code_actions.shellcheck,
	-- 			null_ls.builtins.diagnostics.shellcheck,
	-- 			null_ls.builtins.formatting.beautysh,
	-- 			-- Markdown.
	-- 			null_ls.builtins.diagnostics.markdownlint,
	-- 			null_ls.builtins.formatting.markdownlint,
	-- 			-- JSON & YAML.
	-- 			null_ls.builtins.formatting.jq,
	-- 			null_ls.builtins.diagnostics.yamllint,
	-- 		}
	--
	-- 		null_ls.setup({
	-- 			sources = sources,
	-- 		})
	--
	-- 		-- Update diagnostics even in insert mode. Can slow nvim.
	-- 		vim.diagnostic.config({ update_in_insert = false })
	-- 	end,
	-- },
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
