{
  ...
}:
{
  imports =
  [
    ../customization.nix

    ../desktops/gnome
    ../desktops/hyprland

    ../modules/console/bash.nix
    ../modules/console/gtk.nix
    ../modules/console/kitty.nix
    ../modules/console/starship.nix

    ../modules/dev/dotnet.nix
    ../modules/dev/gamedev.nix
    ../modules/dev/general.nix
    ../modules/dev/git.nix
    ../modules/dev/gtk.nix
    ../modules/dev/java.nix
    ../modules/dev/rust.nix
    ../modules/dev/web.nix

    ../modules/other/docs.nix
    ../modules/other/games.nix
    ../modules/other/gfx.nix
    ../modules/other/pro.nix
    ../modules/other/sfx.nix
  ];

  home.username = "lelimacon";
  home.homeDirectory = "/home/lelimacon";

  home.stateVersion = "24.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
