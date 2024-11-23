{
  pkgs,
  ...
}:
{
  # https://extensions.gnome.org/
  # Enabled in dconf configuration.
  home.packages = with pkgs;
  [
    gnomeExtensions.appindicator
    gnomeExtensions.dash-to-panel
    gnomeExtensions.just-perfection
    gnomeExtensions.sound-output-device-chooser
    gnomeExtensions.space-bar
    gnomeExtensions.tray-icons-reloaded
    gnomeExtensions.user-themes
    gnomeExtensions.vitals

    gnome-characters # Emoji table.
    gnome-tweaks
  ];
}
