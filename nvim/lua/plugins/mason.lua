-- Mason is disabled if we're using Nix (Nix should handle the package installations).
if vim.fn.executable("nix") == 1 then
	return {}
end

-- Handle the installation of the multiple LSPs and other code related packages.
-- Make sure that the corresponding packages managers are available:
-- `pip` with `venv`
-- `cargo`
-- `npm`

return {
	-- Package manager for LSP servers, DAP, linters and formatters.
	{
		"williamboman/mason.nvim",
		lazy = false, -- Need to be load at launch so that the Mason's path is added to PATH.
		cmd = "Mason",
		keys = {
			{ "<Leader>pm", "<CMD>Mason<CR>", desc = "Mason" },
		},
		config = true,
	},
	-- Automatically install packages using Mason.
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		cmd = { "MasonToolsInstall", "MasonToolsUpdate" },
		opts = {
			run_on_start = false,
			auto_update = false,
			ensure_installed = {
				"bash-language-server",
				"black",
				"codespell",
				"debugpy",
				"isort",
				"jq",
				"latexindent",
				"ltex-ls",
				"lua-language-server",
				"markdownlint",
				"marksman",
				"proselint",
				"python-lsp-server",
				"ruff-lsp",
				"shellcheck",
				"shfmt",
				"stylua",
				"yamllint",
			},
		},
	},
}
