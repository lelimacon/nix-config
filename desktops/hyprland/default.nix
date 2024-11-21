{
  pkgs,
  inputs,
  system,
  ...
}:
{
  imports =
  [
    inputs.hyprland.homeManagerModules.default

    ./ags.nix
    ./hyprland.nix
    ./waybar
    ./xdg.nix
  ];

  home.packages = with pkgs;
  [
    # Apps.
    kitty # terminal emulator.
    anyrun walker # app launchers.
    nemo # file explorer.
    wlogout # full-screen logout menu.

    # Daemons.
    swww # wallpaper daemon.
    libnotify dunst # notifications.

    # Plugins.
    waybar
    networkmanagerapplet # tray applet for managing networks.
    udiskie # drives applet.

    # Custom packages.
    inputs.drawernator.packages."${system}".default
  ];
}
