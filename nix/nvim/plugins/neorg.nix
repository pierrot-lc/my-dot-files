{ config, pkgs, lib, ... }:

let
  fromGitHub = import ./build-plugin.nix {inherit pkgs; inherit lib;};
in {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = fromGitHub "nvim-neorg/neorg";
      config = ''
        require("neorg").setup({
            load = {
                -- Loads default behaviour.
                ["core.defaults"] = {},
                -- Adds pretty icons to your documents.
                ["core.concealer"] = {},
                -- Manages Neorg workspaces.
                ["core.dirman"] = {
                    config = {
                        workspaces = {
                            notes = "~/my-notes/",
                        },
                    },
                },
                -- Add completion support.
                ["core.completion"] = {
                    config = {
                        engine = "nvim-cmp",
                    },
                },
                -- Make any Norg file presentable.
                -- Use the `:Neorg presenter start` command.
                ["core.presenter"] = {
                    config = {
                        zen_mode = "zen-mode",
                    },
                },
                ["core.export"] = {},
            },
        })

        -- TODO: Make sure keybindings are only set for Neorg buffers.
        vim.keymap.set("n", "<LocalLeader>c", ":Neorg toggle-concealer<CR>", { desc = "Toggle conceiler" })

        -- TODO: Make sure the hints are added to whichkey
        -- and make sure that they are loaded only for Neorg buffers.
        if pcall(require, "which-key") then
            require("which-key").register({
                ["<LocalLeader>t"] = { name = "+TODO" },
                ["<LocalLeader>n"] = { name = "+Notes" },
                ["<LocalLeader>i"] = { name = "+Insert" },
                ["<LocalLeader>l"] = { name = "+List" },
                ["<LocalLeader>m"] = { name = "+Mode" },
            })
        end
      '';
      type = "lua";
    }

    # Dependencies.
    plenary-nvim
    nvim-treesitter
    zen-mode-nvim
    nvim-cmp
  ];
}
