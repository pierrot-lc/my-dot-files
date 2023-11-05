-- Install lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    print("Installing Lazy.nvim...")
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
    print("Done")
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
	"monaqa/dial.nvim",
    "echasnovski/mini.comment",
    "akinsho/toggleterm.nvim",
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = "nvim-tree/nvim-web-devicons",
    },
}

require("lazy").setup("plugins", {
    change_detection = {
        enabled = true,
        notify = false,
    },
    lockfile = vim.fn.stdpath("data") .. "/lazy-lock.json",
})
