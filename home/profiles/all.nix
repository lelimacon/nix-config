{
  ...
}:
{
  imports =
  [
    ../../desktop.nix
    ../../desktops/gnome
    ../../desktops/hyprland

    ../modules/bash.nix
    ../modules/git.nix
    ../modules/gtk.nix
    ../modules/kitty.nix
    ../modules/scripts.nix
    ../modules/starship.nix
  ];

  home.username = "lelimacon";
  home.homeDirectory = "/home/lelimacon";

  home.stateVersion = "24.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
