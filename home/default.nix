{
  config,
  pkgs,
  ...
}:
{
  imports =
  [
    ./ags.nix
    ./git.nix
    ./gtk.nix
    ./hyprland.nix
    ./terminal.nix
  ];

  home.stateVersion = "24.05";
}
