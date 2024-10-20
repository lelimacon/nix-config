{
  ...
}:
{
  imports =
  [
    ../desktop.nix
    ./ags.nix
    ./git.nix
    ./gtk.nix
    ./hyprland.nix
    ./terminal.nix
  ];

  home.username = "lelimacon";
  home.homeDirectory = "/home/lelimacon";

  home.stateVersion = "24.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
