{ config, pkgs, lib, ... }:

let
  # Thanks to https://github.com/vimjoyer/nvim-nix-video/blob/main/home.nix
  # and https://gist.github.com/nat-418/493d40b807132d2643a7058188bff1ca.
  fromGitHub = repo: pkgs.vimUtils.buildVimPlugin {
    name = "${lib.strings.sanitizeDerivationName repo}";
    src = builtins.fetchGit {
      url = "https://github.com/${repo}.git";
    };
  };
in {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = fromGitHub "monaqa/dial.nvim";
      config = ''
			local augend = require("dial.augend")
			require("dial.config").augends:register_group({
				default = {
					augend.integer.alias.decimal,
					augend.integer.alias.hex,
					augend.date.alias["%Y/%m/%d"],
					augend.constant.alias.alpha,
					augend.constant.alias.Alpha,
					augend.constant.alias.bool,
					augend.constant.new({ elements = { "True", "False" } }),
				},
			})

			vim.api.nvim_set_keymap("n", "<C-a>", require("dial.map").inc_normal(), { noremap = true })
			vim.api.nvim_set_keymap("n", "<C-x>", require("dial.map").dec_normal(), { noremap = true })
      '';
      type = "lua";
    }
  ];
}
