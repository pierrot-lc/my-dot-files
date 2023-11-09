require("ranger-nvim").setup({
	replace_netrw = true,
})

vim.api.nvim_create_user_command("Ranger", "<cmd>lua require('ranger-nvim').open()<cr>", { desc = "Open ranger" })
