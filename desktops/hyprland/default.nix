{
  pkgs,
  inputs,
  ...
}:
{
  imports =
  [
    inputs.hyprland.homeManagerModules.default

    #../../desktop.nix
    ./ags.nix
    #./astal
    ./hyprland.nix
    ./xdg.nix
  ];

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

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
    ags # widget system.
    waybar
    networkmanagerapplet # tray applet for managing networks.
    udiskie # drives applet.
  ];
}
