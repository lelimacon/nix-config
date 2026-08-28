{
  inputs,
  ...
}:
{
  imports =
  [
    #inputs.nixos-hardware.nixosModules.microsoft-surface-common
    # TODO: Remove this as specified in the lib.
    inputs.home-manager.nixosModules.default

    ./hardware-configuration.nix

    ../../hardware/audio.nix
    ../../hardware/bluetooth.nix
    ../../hardware/drives.nix
    ../../hardware/laptop.nix
    ../../hardware/logind.nix
    ../../hardware/network.nix
    ../../hardware/printing.nix
    ../../hardware/virtualization.nix

    ../../modules/culture.nix
    ../../modules/fonts.nix
    ../../modules/gnome.nix
    ../../modules/linux-software.nix
    ../../modules/steam.nix
    ../../modules/console.nix
    ../../modules/system-defaults.nix
    ../../modules/users.nix
    ../../modules/wayland.nix
    ../../modules/xdg.nix
  ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.05";
}
