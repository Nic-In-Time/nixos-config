{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.nixvim = {
    enable = true;
    globals.mapleader = " ";
    imports = [
      ./lsp.nix
      ./nixvim/globals.nix
    ];
    waylandSupport = true;

    colorschemes.onedark.enable = true;
    plugins.telescope = {
      enable = true;

      keymaps = {
        "<leader><leader>" = "find_files";
      };
    };
    plugins.conform-nvim = {
      enable = true;
      settings = {
        format_on_save = {
          lsp_fallback = true;
          timeout_ms = 500;
        };
      };
    };
    plugins.treesitter.enable = true;
    plugins.gitsigns.enable = true;
    plugins.autoclose = {
      enable = true;
    };
    plugins.bufferline.enable = true;
    plugins.lualine.enable = true;
    plugins.trouble.enable = true;

    plugins.blink-cmp.enable = true;

    plugins.highlight-colors.enable = true;

    plugins.transparent = {
      enable = true;
      settings = {
        extra_groups = [
          "BufferLineTabClose"
          "BufferLineBufferSelected"
          "BufferLineFill"
          "BufferLineBackground"
          "BufferLineSeparator"
          "BufferLineIndicatorSelected"
        ];
      };
    };

    diagnostic.settings = {
      virtual_lines = {
        current_line = true;
      };
      update_in_insert = false;
    };

    nixpkgs.config = {
      allowUnfree = true;
    };

  };
}
