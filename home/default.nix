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
    ./hyprland.nix
    ./terminal.nix
  ];

  home.stateVersion = "24.05";
}
