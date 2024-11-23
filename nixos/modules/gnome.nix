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

  # Excluded apps.
  environment.gnome.excludePackages = with pkgs;
  [
    epiphany # "Web" browser.
    geary # email client.
    totem # video player.
    evince # document viewer.
    cheese # webcam.
    yelp gnome-initial-setup gnome-tour # assistance apps.
    gnome-contacts
    gnome-weather
    gnome-maps
    gnome-music
    gnome-photos
  ];

  # Extensions.
  # https://extensions.gnome.org/
  environment.systemPackages = with pkgs;
  [
    gnomeExtensions.just-perfection
    gnomeExtensions.appindicator
    gnomeExtensions.user-themes
    gnomeExtensions.tray-icons-reloaded
    gnomeExtensions.vitals
    gnomeExtensions.dash-to-panel
    gnomeExtensions.sound-output-device-chooser
    gnomeExtensions.space-bar

    gnome-characters # Emoji table.
    gnome-tweaks
  ];
}
