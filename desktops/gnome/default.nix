{
  config,
  pkgs,
  ...
}:
{
  imports =
  [
    #../../desktop.nix
    ./dconf.nix
  ];

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Excluded apps.
  environment.gnome.excludePackages = with pkgs;
  [
    gnome.epiphany # "Web" browser.
    gnome.geary # email client.
    gnome.totem # video player.
    gnome.evince # document viewer.
    gnome.cheese # webcam.
    gnome.yelp gnome.gnome-initial-setup gnome-tour # assistance apps.
    gnome.gnome-contacts
    gnome.gnome-weather
    gnome.gnome-maps
    gnome.gnome-music
    gnome-photos
  ];

  # Extensions.
  # https://extensions.gnome.org/
  environment.systemPackages = with pkgs;
  [
    pkgs.gnome3.gnome-tweaks
    gnomeExtensions.just-perfection
    gnomeExtensions.appindicator
    gnomeExtensions.user-themes
    gnomeExtensions.tray-icons-reloaded
    gnomeExtensions.vitals
    gnomeExtensions.dash-to-panel
    gnomeExtensions.sound-output-device-chooser
    gnomeExtensions.space-bar

    gnome.gnome-characters # Emoji table.
  ];
}
