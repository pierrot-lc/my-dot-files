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
			"lukas-reineke/cmp-rg", -- Use results from `ripgrep` as a source.
		},
		config = function()
			local lspconfig = require("lspconfig")
			local lspdefaults = lspconfig.util.default_config
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local cmp = require("cmp")

			vim.opt.completeopt = { "menu", "menuone", "noselect" }

			-- Add completion capabilities to default LSP capabilities.
			lspdefaults.capabilities = vim.tbl_deep_extend("force", lspdefaults.capabilities, capabilities)

			-- This function is used to check if the cursor is at the beginning of a word.
			-- It is used to prevent completion from being triggered when inserting a tab.
			local has_words_before = function()
				unpack = unpack or table.unpack
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0
					and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end

			local kind_icons = {
				Text = " ",
				Method = "󰆧 ",
				Function = "󰊕 ",
				Constructor = " ",
				Field = "󰇽 ",
				Variable = "󰂡 ",
				Class = "󰠱 ",
				Interface = " ",
				Module = " ",
				Property = "󰜢 ",
				Unit = " ",
				Value = "󰎠 ",
				Enum = " ",
				Keyword = "󰌋 ",
				Snippet = " ",
				Color = "󰏘 ",
				File = "󰈙 ",
				Reference = " ",
				Folder = "󰉋 ",
				EnumMember = " ",
				Constant = "󰏿 ",
				Struct = " ",
				Event = " ",
				Operator = "󰆕 ",
				TypeParameter = "󰅲 ",
			}
			local menu_icons = {
				nvim_lsp = "λ ",
				calc = " ",
				path = " ",
				rg = " ",
				neorg = " ",
			}

			cmp.setup({
				sources = {
					{ name = "path" },
					{ name = "nvim_lsp" },
					{ name = "calc" },
					{ name = "rg" },
					{ name = "neorg" }, -- Optional, used in Neorg files.
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				formatting = {
					fields = { "menu", "abbr", "kind" },
					format = function(entry, item)
						item.menu = menu_icons[entry.source.name]
						item.kind = string.format("%s %s", kind_icons[item.kind] or "󰠱 ", item.kind)

						-- Remove duplicate entries from some sources.
						local item_dup = {
							rg = 0,
						}
						item.dup = item_dup[entry.source.name] or 1

						return item
					end,
				},
				mapping = {
					["<Up>"] = cmp.mapping.select_prev_item(),
					["<Down>"] = cmp.mapping.select_next_item(),
					["<C-d>"] = cmp.mapping.scroll_docs(4),
					["<C-u>"] = cmp.mapping.scroll_docs(-4),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
					["<TAB>"] = cmp.mapping(function(fallback)
						if cmp.visible() and has_words_before() then
							-- We make sure there's a word before the cursor,
							-- otherwise `cmp` could be triggered when we don't want to.
							cmp.select_next_item()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-TAB>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						else
							fallback()
						end
					end, { "i", "s" }),
				},
				sorting = {
					priority_weight = 2,
					comparators = {
						cmp.config.compare.offset,
						cmp.config.compare.exact,
						cmp.config.compare.score,
						cmp.config.compare.recently_used,
						cmp.config.compare.locality,
						cmp.config.compare.kind,
						cmp.config.compare.sort_text,
						cmp.config.compare.length,
						cmp.config.compare.order,
					},
				},
			})
		end,
	},
}
