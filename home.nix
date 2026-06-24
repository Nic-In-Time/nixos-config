{
  config,
  pkgs,
  inputs,
  ...
}:

{
  home.username = "nic";
  home.homeDirectory = "/home/nic";
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    nodejs
  ];

  imports = [
  ];
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    colorschemes.onedark.enable = true;
    plugins.telescope.enable = true;
    plugins.lsp = {
      enable = true;
      servers = {
        # Nix language server
        nil_ls.enable = true;
        # Markdown language server
        marksman.enable = true;
        # shell script language server (sh, bash, zsh)
        bashls = {
          enable = true;
          filetypes = [
            "sh"
            "bash"
            "zsh"
          ];
        };
        # TypeScript / JavaScript language server
        ts_ls.enable = true;
        # R language server
        # package = null: relies on R (with languageserver) provided by the project's R flake
        r_language_server = {
          enable = true;
          package = null;
        };
        # OCaml language server
        ocamllsp.enable = true;
        # Haskell language server
        hls = {
          enable = true;
          installGhc = true;
        };
        # Typst language server
        tinymist.enable = true;
        # C language server
        clangd.enable = true;
        # Python language server
        basedpyright.enable = true;
        # HTML language server
        html.enable = true;
        # CSS language server
        cssls.enable = true;
        # Java language server
        jdtls.enable = true;
        # Julia language server
        # package = null: relies on LanguageServer.jl installed in the Julia environment
        julials = {
          enable = true;
          package = null;
        };
        # Go language server
        gopls.enable = true;
        # TOML language server
        taplo.enable = true;
        # JSON language server (included in vscode-langservers-extracted, same as html/cssls)
        jsonls.enable = true;
        # YAML language server
        yamlls = {
          enable = true;
          settings.yaml.schemas = {
            # GitHub Actions workflow schema
            "https://json.schemastore.org/github-workflow.json" = ".github/workflows/*.{yml,yaml}";
          };
        };
        # Elm language server
        elmls.enable = true;
        # Astro language server
        astro.enable = true;
        # Dockerfile language server
        dockerls.enable = true;
        # Docker Compose language server
        docker_compose_language_service.enable = true;
        # Makefile language server
        autotools_ls.enable = true;

        # LaTeX language server
        texlab.enable = true;
        # Assembly (NASM/GAS) language server
        asm_lsp.enable = true;
        # Graphviz DOT language server
        dotls.enable = true;
        # Rust language server
        rust_analyzer = {
          enable = true;
          installCargo = true;
          installRustc = true;
        };
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
    plugins.autoclose.enable = true;
    plugins.bufferline.enable = true;
    plugins.lualine.enable = true;

  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Nic.In.Time";
        email = "nicintime9@gmail.com";
      };
      init.defaultBranch = "main";
    };
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake /home/nic/.config/nixos/";
      server1 = "ssh testing@ssh1.nicintime.ca";
      server2 = "ssh testing@ssh2.nicintime.ca";
      hypr = "start-hyprland";
    };
  };

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.catppuccin-cursors.mochaMauve;
    name = "catppuccin-mocha-mauve-cursors";
    size = 24;
  };

  gtk = {
    enable = true;
    cursorTheme = {
      package = pkgs.catppuccin-cursors.mochaMauve;
      name = "catppuccin-mocha-mauve-cursors";
    };
  };

  programs.ssh = {
    enable = true;
    settings = {

      "Host *.nicintime.ca" = {
        ProxyCommand = "${pkgs.cloudflared}/bin/cloudflared access ssh --hostname %h";
      };

    };
  };

}
