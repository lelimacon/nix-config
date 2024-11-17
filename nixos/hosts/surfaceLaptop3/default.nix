{
  inputs,
  ...
}:
{
  imports =
  [
    ../../modules/culture.nix
    ../../modules/fonts.nix
    ../../modules/hyprland.nix
    ../../modules/programs.nix
    ../../modules/users.nix
    ../../modules/wayland.nix
    ../../modules/x11.nix

    ./hardware-configuration.nix
    ./hardware-overrides.nix

    inputs.home-manager.nixosModules.default
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
    #users."lelimacon" =
    #{
    #  imports =
    #  [
    #    ../home
    #    ../desktop/gnome
    #    ../desktop/hyprland
    #  ];
    #};
    #users."lelimacon" = import ../../desktop/hyprland;
    extraSpecialArgs =
    {
      inherit inputs;
    };
  };
}
