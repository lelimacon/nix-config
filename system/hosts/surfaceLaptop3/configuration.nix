{
  inputs,
  outputs,
  system,
  pkgs,
  pkgs-local,
  pkgs-unstable,
  vars,
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
    ../../modules/linux-software.nix
    ../../modules/steam.nix
    ../../modules/system-defaults.nix
    ../../modules/users.nix
    ../../modules/wayland.nix
    #../../modules/x11.nix
    ../../modules/xdg.nix

    ./hardware-configuration.nix
    ./hardware-overrides.nix
  ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.05";

  # Tie Home Manager to system configuration.
  # TODO: Remove from here.
  home-manager =
  {
    users."lelimacon" = import ../../../home/profiles/surface-laptop-3.nix;
    extraSpecialArgs = { inherit inputs outputs vars system pkgs pkgs-local pkgs-unstable; };
  };
}
