{
  description = "Hyprland yay";
  inputs = {
    aagl.url = "github:ezKEa/aagl-gtk-on-nix/release-26.05";
    aagl.inputs.nixpkgs.follows = "nixpkgs";
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
    };
    qylock.url = "github:Darkkal44/qylock";
  };
  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      aagl,
      qylock,
      nixvim,
      ...
    }@inputs:
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;

            };
          }
          {
            imports = [ aagl.nixosModules.default ];
            nix.settings = aagl.nixConfig; # Set up Cachix
            programs.anime-game-launcher = {
              enable = true; # Adds launcher and /etc/hosts rules
            };
            programs.anime-games-launcher.enable = true;
            programs.honkers-railway-launcher = {
              enable = true;
            };
            programs.honkers-launcher.enable = true;
            programs.wavey-launcher.enable = true;
            programs.sleepy-launcher.enable = true;
          }
          qylock.nixosModules.default
          ({ pkgs, ... }: {
            services.displayManager.sddm.enable = true;
            services.displayManager.sddm.wayland.enable = true;

            programs.qylock = {
              enable = true;
              theme = "osu"; # any directory name under themes/
              # sddm.enable = true;             # installs theme + sets it active (default)
              # quickshell.enable = true;       # adds `qylock-lock` to PATH (default)

              # Optional per-theme tweaks (replaces the interactive prompts):
              themeOptions = {
                terraria.backgroundMode = "time"; # time | random | static
                Genshin.backgroundMode = "time";
                clockwork.orbital = {
                  themeMode = "dark";
                  enableWindup = true;
                };
                osu.gameMode = "menu"; # menu | game
              };
            };
          })
        ];
      };
    };
}
