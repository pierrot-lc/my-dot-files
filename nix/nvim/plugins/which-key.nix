{ config, pkgs, lib, ... }:

{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = which-key-nvim;
      config = ''
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
      '';
      type = "lua";
    }
  ];
}
