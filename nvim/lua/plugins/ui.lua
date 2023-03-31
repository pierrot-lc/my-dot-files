return {
	-- Enhance the basic ui.
	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
		enabled = false,
	},
	-- Classic vim theme.
	{
		"sainnhe/gruvbox-material",
		enabled = false,
		dependencies = { "bluz71/nvim-linefly" },
		lazy = false,
		priority = 1000,
		config = function()
			vim.opt.termguicolors = true -- Activate terminal colors.
			vim.opt.background = "dark" -- Global theme.
			vim.g.gruvbox_material_background = "hard" -- Either "hard", "medium" or "soft".
			vim.g.gruvbox_material_better_performance = 1
			vim.cmd("colorscheme gruvbox-material")

			local highlight = vim.api.nvim_set_hl
			highlight(0, "LineflyNormal", { link = "DiffChange" })
			highlight(0, "LineflyInsert", { link = "WildMenu" })
			highlight(0, "LineflyVisual", { link = "IncSearch" })
			highlight(0, "LineflyCommand", { link = "WildMenu" })
			highlight(0, "LineflyReplace", { link = "ErrorMsg" })
		end,
	},
	-- Nice colorschemes.
	{
		"catppuccin/nvim",
		lazy = false,
		priority = 1000,
		dependencies = { "bluz71/nvim-linefly" },
		config = function()
			require("catppuccin").setup({
				flavour = "mocha", -- latte, frappe, macchiato, mocha
				background = {
					-- :h background
					light = "latte",
					dark = "mocha",
				},
				transparent_background = false,
				show_end_of_buffer = false, -- show the '~' characters after the end of buffers
				term_colors = false,
				dim_inactive = {
					enabled = false,
					shade = "dark",
					percentage = 0.15,
				},
				no_italic = false, -- Force no italic
				no_bold = false, -- Force no bold
				styles = {
					comments = { "italic" },
					conditionals = { "italic" },
					loops = {},
					functions = {},
					keywords = {},
					strings = {},
					variables = {},
					numbers = {},
					booleans = {},
					properties = {},
					types = {},
					operators = {},
				},
				color_overrides = {},
				custom_highlights = {},
				integrations = {
					cmp = true,
					dap = { enabled = true, enable_ui = true },
					fidget = true,
					gitsigns = true,
					leap = true,
					markdown = true,
					mason = true,
					native_lsp = { enabled = true },
					nvimtree = true,
					telescope = true,
					treesitter = true,
					which_key = true,
				},
			})

			vim.opt.background = "dark" -- Global theme.
			vim.cmd.colorscheme("catppuccin")

			-- Set linefly colors.
			local highlight = vim.api.nvim_set_hl
			highlight(0, "LineflyNormal", { link = "DiffChange" })
			highlight(0, "LineflyInsert", { link = "WildMenu" })
			highlight(0, "LineflyVisual", { link = "IncSearch" })
			highlight(0, "LineflyCommand", { link = "WildMenu" })
			highlight(0, "LineflyReplace", { link = "ErrorMsg" })
		end,
	},
	-- Show git signs.
	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		config = true,
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
				["<leader>v"] = { name = "+Neovim" },
				["<leader>p"] = { name = "+Panels" },
				["<leader>t"] = { name = "+Telescope" },
				["<leader>d"] = { name = "+Debugger" },
				["<leader>l"] = { name = "+LSP" },
				["<leader>m"] = { name = "+Misc" },
			})
		end,
	},
	-- Status line.
	{
		"bluz71/nvim-linefly",
		event = "VeryLazy",
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
		end,
	},
	-- Welcoming panel.
	{
		"goolord/alpha-nvim",
		event = "VimEnter",
		opts = function()
			local dashboard = require("alpha.themes.dashboard")
			local welcome_msgs = {
				"Hello Killian! Let's code!",
				"Welcome, Killian! Ready to hack?",
				"Hey Killian! Let's write some code!",
				"Good to have you here, Killian!",
				"Killian, let's make some magic!",
				"Hi Killian! Ready to code and chill?",
				"Welcome, Killian! Time to code!",
				"Hello Killian! Let's get coding!",
				"Greetings, Killian! Ready to rock?",
				"Killian, let's start coding!",
				"Hey Killian! Let's create something!",
				"Welcome, Killian! Let's code some awesomeness!",
				"Hi Killian! Ready to conquer code?",
				"Hello Killian! Let's make some tech art!",
				"Good to see you, Killian! Let's code!",
				"Killian, let's write some amazing code!",
				"Welcome, Killian! Let's make some software!",
				"Hey Killian! Let's build something cool!",
				"Hello Killian! Let's make some code magic!",
				"Hi Killian! Ready to create some tech?",
				"Welcome, Killian! Let's write some code!",
				"Hey Killian! Let's code and have fun!",
				"Hello Killian! Let's make some tech dreams!",
				"Good to have you here, Killian! Let's code!",
				"Killian, let's make some coding history!",
				"Hi Killian! Ready to make some software?",
				"Welcome, Killian! Let's write some epic code!",
				"Hey Killian! Let's hack and learn!",
				"Hello Killian! Let's code and change the world!",
				"Good to see you, Killian! Let's build something amazing!",
			}
			local logo = [[
$$\   $$\                    $$\    $$\ $$\
$$$\  $$ |                   $$ |   $$ |\__|
$$$$\ $$ | $$$$$$\   $$$$$$\ $$ |   $$ |$$\ $$$$$$\$$$$\
$$ $$\$$ |$$  __$$\ $$  __$$\\$$\  $$  |$$ |$$  _$$  _$$\
$$ \$$$$ |$$$$$$$$ |$$ /  $$ |\$$\$$  / $$ |$$ / $$ / $$ |
$$ |\$$$ |$$   ____|$$ |  $$ | \$$$  /  $$ |$$ | $$ | $$ |
$$ | \$$ |\$$$$$$$\ \$$$$$$  |  \$  /   $$ |$$ | $$ | $$ |
\__|  \__| \_______| \______/    \_/    \__|\__| \__| \__|

]] .. welcome_msgs[math.random(#welcome_msgs)]
			dashboard.section.header.val = vim.split(logo, "\n")
			dashboard.section.buttons.val = {
				dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
				dashboard.button("n", " " .. " New file", ":ene <BAR> startinsert <CR>"),
				dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
				dashboard.button("g", " " .. " Find text", ":Telescope live_grep <CR>"),
				dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
				dashboard.button("s", "勒" .. " Restore Session", [[:lua require("persistence").load() <cr>]]),
				dashboard.button("l", "鈴" .. " Lazy", ":Lazy<CR>"),
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
