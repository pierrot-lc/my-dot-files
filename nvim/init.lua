-- ========================================================================== --
-- ==                           EDITOR SETTINGS                            == --
-- ========================================================================== --
vim.g.loaded_netrw = 1 -- Deactivate netrw file manager (handled by a plugin).
vim.g.loaded_netrwPlugin = 1
vim.wo.number = true -- Show line numbers default.
vim.wo.relativenumber = false
vim.opt.mouse = "a" -- Enable mouse for all modes.
vim.opt.undofile = true -- Save undo history.
vim.opt.hlsearch = true -- Set highlight on search. Turning this off will remove the highlight after searching for text.
vim.opt.ignorecase = true -- Case insensitive searching unless /C or capital in search.
vim.opt.smartcase = true
vim.opt.wrap = true -- Whether or not we want to wrap long lines.
vim.opt.breakindent = true -- Enable break indent. Conserve indentation of virtual wrapped lines.
vim.opt.cursorline = true -- Highlight cursor line.
vim.opt.scrolloff = 5 -- Offset before scrolling.
vim.wo.signcolumn = "yes" -- Always shows the sign column (where we put gitsigns and warnings).
vim.opt.updatetime = 1000 -- Decrease update time (default is 4000).
vim.opt.tabstop = 4 -- Amount of spaces a 'tab' character occupy.
vim.opt.shiftwidth = 4 -- Amount of spaces are used to indent a line.
vim.opt.expandtab = true -- Whether or not we want to transform tabs to spaces.
vim.opt.list = true -- Show invisible spaces.
vim.opt.listchars:append({
	tab = "» ",
	extends = "›",
	precedes = "‹",
	trail = "·",
	nbsp = "·",
	-- eol = '↵',
})
vim.g.mapleader = " " -- Redefine leader key.

require("plugins")
require("keybindings")
require("commands")
