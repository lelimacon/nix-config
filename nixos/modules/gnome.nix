{
  config,
  pkgs,
  ...
}:
{
  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Enable dconf (configured in /home/desktops/gnome).
  programs.dconf.enable = true;

  # Remove all default apps.
  # Some may be added back in home manager.
  environment.gnome.excludePackages = with pkgs;
  [
    cheese # webcam.
    epiphany # "Web" browser.
    evince # document viewer.
    geary # email client.
    gnome-characters # Emoji table.
    gnome-contacts
    gnome-maps
    gnome-music
    gnome-photos
    gnome-weather
    totem # video player.
    yelp gnome-initial-setup gnome-tour # assistance apps.
  ];
}
