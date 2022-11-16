-- ========================================================================== --
-- ==                           LSP CONFIGURATION                          == --
-- ========================================================================== --
-- Load mason before setting up LSP servers.
require("mason").setup()
require("mason-lspconfig").setup({})

-- Add neovim lua library support to `sumneko_lua`.
require("neodev").setup()

-- Load LSP servers.
local lspconfig = require("lspconfig")
lspconfig["pyright"].setup({})
lspconfig["sumneko_lua"].setup({})
lspconfig["marksman"].setup({})
lspconfig["rust_analyzer"].setup({})
require("lsp_signature").setup({
	bind = true,
	handler_opts = {
		border = "rounded",
	},
})

-- null-ls configurations.
local null_ls = require("null-ls")
local sources = {
	null_ls.builtins.diagnostics.codespell,
	null_ls.builtins.code_actions.proselint,
	null_ls.builtins.formatting.black,
	null_ls.builtins.diagnostics.flake8.with({
		extra_args = { "--max-line-length=88", "--extend-ignore=E203" } -- Black configuration
	}),
	null_ls.builtins.formatting.isort.with({
		extra_args = { "--profile=black" } -- Black configuration
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
-- vim.diagnostic.config({ update_in_insert = true })

-- ========================================================================== --
-- ==                      AUTOCOMPLETION CONFIGURATION                    == --
-- ========================================================================== --
vim.opt.completeopt = { "menu", "menuone", "noselect" }

local lspconfig = require("lspconfig")
local cmp = require("cmp")
local luasnip = require("luasnip")
local lsp_defaults = lspconfig.util.default_config
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local select_opts = { behavior = cmp.SelectBehavior.Replace }

-- Add completion capabilities to default LSP capabilities.
lsp_defaults.capabilities = vim.tbl_deep_extend("force", lsp_defaults.capabilities, capabilities)

-- Add some snippets using `friendly-snippets` plugin.
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	sources = {
		{ name = "path" },
		{ name = "nvim_lsp" },
		{ name = "buffer" },
		{ name = "luasnip" },
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	formatting = {
		fields = { "menu", "abbr", "kind" },
		format = function(entry, item)
			local menu_icon = {
				nvim_lsp = "λ",
				luasnip = "⋗",
				buffer = "Ω",
				path = "",
			}

			item.menu = menu_icon[entry.source.name]
			return item
		end,
	},
	mapping = {
		["<Up>"] = cmp.mapping.select_prev_item(select_opts),
		["<Down>"] = cmp.mapping.select_next_item(select_opts),

		["<C-p>"] = cmp.mapping.select_prev_item(select_opts),
		["<C-n>"] = cmp.mapping.select_next_item(select_opts),

		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),

		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = false }),

		["<C-d>"] = cmp.mapping(function(fallback)
			if luasnip.jumpable(1) then
				luasnip.jump(1)
			else
				fallback()
			end
		end, { "i", "s" }),

		["<C-b>"] = cmp.mapping(function(fallback)
			if luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),

		["<Tab>"] = cmp.mapping(function(fallback)
			local col = vim.fn.col(".") - 1

			if cmp.visible() then
				cmp.select_next_item(select_opts)
			elseif col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
				fallback()
			else
				cmp.complete()
			end
		end, { "i", "s" }),

		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item(select_opts)
			else
				fallback()
			end
		end, { "i", "s" }),
	},
})
