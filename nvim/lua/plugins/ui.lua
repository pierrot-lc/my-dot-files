return {
	-- Enhance the basic ui.
	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
		enabled = true,
	},
	-- Dynamically show keybindings.
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function()
			vim.opt.timeout = true
			vim.opt.timeoutlen = 300
			require("which-key").setup()
			require("which-key").register({
				["<Leader>v"] = { name = "+Neovim" },
				["<Leader>p"] = { name = "+Panels" },
				["<Leader>t"] = { name = "+Telescope" },
				["<Leader>d"] = { name = "+Debugger" },
				["<Leader>l"] = { name = "+LSP" },
				["gc"] = { name = "+Comment" },
			})
		end,
	},
	-- Status line.
	{
		"bluz71/nvim-linefly",
		lazy = false,
		dependencies = { "nvim-tree/nvim-web-devicons" }, -- More icons.
		config = function()
			vim.g.linefly_options = {
				tabline = true,
				winbar = true,
				with_file_icon = true,
				with_git_branch = true,
				with_git_status = true,
				with_diagnostic_status = true,
				with_indent_status = true,
			}
			vim.opt.showmode = false -- Remove the default status line.

			-- Set linefly colors.
			local highlight = vim.api.nvim_set_hl
			highlight(0, "LineflyNormal", { link = "DiffChange" })
			highlight(0, "LineflyInsert", { link = "WildMenu" })
			highlight(0, "LineflyVisual", { link = "IncSearch" })
			highlight(0, "LineflyCommand", { link = "WildMenu" })
			highlight(0, "LineflyReplace", { link = "ErrorMsg" })
		end,
	},
	-- Welcoming panel.
	{
		"goolord/alpha-nvim",
		event = "VimEnter",
		opts = function()
			local dashboard = require("alpha.themes.dashboard")
			local logo = [[
$$\   $$\                    $$\    $$\ $$\
$$$\  $$ |                   $$ |   $$ |\__|
$$$$\ $$ | $$$$$$\   $$$$$$\ $$ |   $$ |$$\ $$$$$$\$$$$\
$$ $$\$$ |$$  __$$\ $$  __$$\\$$\  $$  |$$ |$$  _$$  _$$\
$$ \$$$$ |$$$$$$$$ |$$ /  $$ |\$$\$$  / $$ |$$ / $$ / $$ |
$$ |\$$$ |$$   ____|$$ |  $$ | \$$$  /  $$ |$$ | $$ | $$ |
$$ | \$$ |\$$$$$$$\ \$$$$$$  |  \$  /   $$ |$$ | $$ | $$ |
\__|  \__| \_______| \______/    \_/    \__|\__| \__| \__|


]]

			dashboard.section.header.val = vim.split(logo, "\n")
			dashboard.section.buttons.val = {
				dashboard.button("n", " " .. " New file", ":ene <BAR> startinsert<CR>"),
				dashboard.button("p", " " .. " Projects", ":Telescope repo list<CR>"),
				dashboard.button("r", "󱋡 " .. " Recent files", ":Telescope oldfiles<CR>"),
				dashboard.button("f", "󰈢 " .. " Find file", ":Telescope find_files<CR>"),
				dashboard.button("g", "󰺮 " .. " Find text", ":Telescope live_grep<CR>"),
				dashboard.button("c", " " .. " Config", ":e $MYVIMRC<CR>"),
				dashboard.button("l", "󰒲 " .. " Lazy", ":Lazy<CR>"),
				dashboard.button("q", " " .. " Quit", ":qa<CR>"),
			}
			for _, button in ipairs(dashboard.section.buttons.val) do
				button.opts.hl = "AlphaButtons"
				button.opts.hl_shortcut = "AlphaShortcut"
			end
			dashboard.section.footer.opts.hl = "Type"
			dashboard.section.header.opts.hl = "AlphaHeader"
			dashboard.section.buttons.opts.hl = "AlphaButtons"
			dashboard.opts.layout[1].val = 8
			return dashboard
		end,
		config = function(_, dashboard)
			vim.b.miniindentscope_disable = true

			-- close Lazy and re-open when the dashboard is ready
			if vim.o.filetype == "lazy" then
				vim.cmd.close()
				vim.api.nvim_create_autocmd("User", {
					pattern = "AlphaReady",
					callback = function()
						require("lazy").show()
					end,
				})
			end

			require("alpha").setup(dashboard.opts)

			vim.api.nvim_create_autocmd("User", {
				pattern = "LazyVimStarted",
				callback = function()
					local stats = require("lazy").stats()
					local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
					dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
					pcall(vim.cmd.AlphaRedraw)
				end,
			})
		end,
	},
}
