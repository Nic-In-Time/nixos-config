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
    pkgs.devenv
  ];

  imports = [
    ./../nixvim.nix
  ];

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
      update = "sudo nix flake update --flake /home/nic/.config/nixos/";
      ssh-nyx = "ssh nyx@ssh.nicintime.ca";
      ssh-testing = "ssh testing@ssh2.nicintime.ca";
      hypr = "start-hyprland";
      dawson-vpn = "sudo openfortivpn -c ~/.config/nixos/vpn-config.txt --saml-login";
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
    enableDefaultConfig = false;
    settings = {

      "Host *.nicintime.ca" = {
        ProxyCommand = "${pkgs.cloudflared}/bin/cloudflared access ssh --hostname %h";
      };

    };
  };

}
