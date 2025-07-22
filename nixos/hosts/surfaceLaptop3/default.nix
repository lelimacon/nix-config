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
    inputs.home-manager.nixosModules.default

    ../../modules/system/culture.nix
    ../../modules/system/fonts.nix
    ../../modules/system/gnome.nix
    ../../modules/system/hyprland.nix
    ../../modules/system/users.nix
    ../../modules/system/wayland.nix
    ../../modules/system/x11.nix

    ../../modules/programs/docs.nix
    ../../modules/programs/games.nix
    ../../modules/programs/general.nix
    ../../modules/programs/graphics.nix
    ../../modules/programs/music.nix

    ../../modules/dev/gamedev.nix
    ../../modules/dev/general.nix
    ../../modules/dev/gtk.nix
    ../../modules/dev/java.nix
    ../../modules/dev/rust.nix
    ../../modules/dev/web.nix

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
