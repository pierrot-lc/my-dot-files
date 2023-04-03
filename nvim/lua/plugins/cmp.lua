return {
	-- Main completion package.
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"neovim/nvim-lspconfig",
			"hrsh7th/cmp-nvim-lsp", -- Handle `nvim-cmp` interactions with neovim's LSP.
			"hrsh7th/cmp-path", -- Filesystem paths source for completion.
			"hrsh7th/cmp-calc", -- Replace simple computations with their results.
			"L3MON4D3/LuaSnip", -- Propose snippets.
			"saadparwaiz1/cmp_luasnip", -- Use `LuaSnip` snippets source for completion.
			"lukas-reineke/cmp-rg", -- Use results from `ripgrep` as a source.
			"zbirenbaum/copilot-cmp", -- Copilot source.
		},
		config = function()
			local lspconfig = require("lspconfig")
			local lspdefaults = lspconfig.util.default_config
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local select_opts = { behavior = cmp.ConfirmBehavior.Replace, select = false }

			vim.opt.completeopt = { "menu", "menuone", "noselect" }

			-- Add completion capabilities to default LSP capabilities.
			lspdefaults.capabilities = vim.tbl_deep_extend("force", lspdefaults.capabilities, capabilities)

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
					{ name = "calc" },
					{ name = "luasnip" },
					{ name = "rg" },
					{ name = "neorg" }, -- Optional, used in Neorg files.
					{ name = "copilot" }, -- Optional, used if Copilot is loaded.
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
							calc = "",
							path = "",
							rg = "",
							neorg = "",
							copilot = "",
						}
						item.menu = menu_icon[entry.source.name]

						-- Remove duplicate entries from some sources.
						local item_dup = {
							rg = 0,
							copilot = 0,
						}
						item.dup = item_dup[entry.source.name] or 1

						return item
					end,
				},
				mapping = {
					["<Up>"] = cmp.mapping.select_prev_item(select_opts),
					["<Down>"] = cmp.mapping.select_next_item(select_opts),
					["<C-d>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item({ cmp.SelectBehavior.Select, select = true })
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item({ cmp.SelectBehavior.Select, select = true })
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				},
			})
		end,
	},
	{
		"L3MON4D3/LuaSnip",
		-- Build `jsregexp` to apply some code transformations.
		-- This build needs the `luajit-dev` package to be installed!
		build = "make install_jsregexp",
	},
	-- Add some snippets to `LuaSnip`.
	{
		"rafamadriz/friendly-snippets",
		event = "InsertEnter",
		dependencies = {
			"L3MON4D3/LuaSnip",
		},
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},
}
