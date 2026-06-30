{ self, pkgs, ... }:
{
  opts = {
    number = true;

    termguicolors = true;

    clipboard = {
      register = "unnamedplus";
      provider = "wl-copy";
    };

    undofile = true;
    swapfile = true;
    backup = false;
    autoread = true;
  };
}
