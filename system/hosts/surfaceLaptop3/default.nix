{
  inputs,
  outputs,
  system,
  pkgs,
  pkgs-unstable,
  ...
}:
{
  imports =
  [
    #inputs.nixos-hardware.nixosModules.microsoft-surface-common
    inputs.home-manager.nixosModules.default

    ../../modules/culture.nix
    ../../modules/fonts.nix
    ../../modules/gnome.nix
    #../../modules/hyprland.nix
    ../../modules/programs.nix
    ../../modules/users.nix
    ../../modules/wayland.nix
    #../../modules/x11.nix
    ../../modules/xdg.nix

    ./hardware-configuration.nix
    ./hardware-overrides.nix
  ];

  nix.settings =
  {
    experimental-features = [ "nix-command" "flakes" ];
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.05";

  # Tie Home Manager to system configuration.
  home-manager =
  {
    users."lelimacon" = import ../../../home/profiles/all.nix;
    extraSpecialArgs = { inherit inputs outputs system pkgs pkgs-unstable; };
  };
}
