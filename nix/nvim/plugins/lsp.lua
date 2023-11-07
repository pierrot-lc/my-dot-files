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
vim.keymap.set("n", "<leader>ld", toggle_diagnostics, { desc = "Toggle diagnostics" })

-- Bind the `lsp_signature` to the LSP servers.
-- This has to be called after the setup of LSPs.
local signature_opts = {
	bind = true,
	floating_window = true,
	handler_opts = { border = "rounded" },
	hint_enable = false,
	wrap = false,
	hi_parameter = "Search",
}
require("lsp_signature").setup(signature_opts)

-- LSP keymappings.
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "gl", function()
	return vim.diagnostic.open_float(nil, { focus = false })
end, { desc = "Show diagnostics" })
vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, { desc = "Show signature" })
vim.keymap.set("n", "gr", vim.lsp.buf.rename, { desc = "Rename symbol" })
vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { desc = "Show code actions" })
