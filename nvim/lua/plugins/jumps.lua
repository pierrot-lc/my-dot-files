return {
	-- Better "w", "e", "b" moves.
	{
		"chrisgrieser/nvim-spider",
		keys = {
			{ "w",  "<CMD> lua require('spider').motion('w')<CR>",  desc = "Spider-w" },
			{ "e",  "<CMD> lua require('spider').motion('e')<CR>",  desc = "Spider-e" },
			{ "b",  "<CMD> lua require('spider').motion('b')<CR>",  desc = "Spider-b" },
			{ "ge", "<CMD> lua require('spider').motion('ge')<CR>", desc = "Spider-ge" },
		},
	},
	-- Move quickly anywhere in the visible editor area.
	{
		"ggandor/leap.nvim",
		keys = {
			{
				"<Leader>s",
				"<CMD>lua require('leap').leap({ target_windows = { vim.fn.win_getid() } })<CR>",
				desc = "Leap",
			},
		},
	},
	-- Restore cursor to previous place.
	{
		"farmergreg/vim-lastplace",
	},
	-- Mark files to quickly find them.
	-- TODO: Add more keybindings.
	-- TODO: Check about scopes. Find a way to mark specific locations in the files.
	{
		"cbochs/grapple.nvim",
		keys = {
			{ "<Leader>gt", "<CMD>GrappleTag<CR>",        desc = "Grapple tag" },
			{ "<Leader>gu", "<CMD>GrappleUntag<CR>",      desc = "Grapple untag" },
			{ "<Leader>gm", "<CMD>GrapplePopup tags<CR>", desc = "Grapple menu" },
		},
		dependencies = { "nvim-lua/plenary.nvim" },
	},
}
