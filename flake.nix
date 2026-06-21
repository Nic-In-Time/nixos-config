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
   };
   outputs = { self, nixpkgs, home-manager, aagl, ...}: {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
         system = "x86_64-linux";
	     modules = [ ./configuration.nix
	        home-manager.nixosModules.home-manager {
	           home-manager = {
	              useGlobalPkgs = true;
		          useUserPackages = true;
		          users.nic = import ./home.nix;
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
	     ];
      };
   };
}
