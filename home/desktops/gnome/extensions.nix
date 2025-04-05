{
  pkgs,
  ...
}:
{
  # https://extensions.gnome.org/
  # Enabled in dconf configuration.
  home.packages = with pkgs;
  [
    gnomeExtensions.appindicator # AppIndicator and KStatusNotifierItem support.
    gnomeExtensions.dash-to-panel # Windows-style taskbar.
    gnomeExtensions.just-perfection # tweak tool.
    gnomeExtensions.space-bar # better workspaces indicator.
    gnomeExtensions.user-themes # User Themes.
    gnomeExtensions.vitals # system information.
    gnomeExtensions.steal-my-focus-window # remove 'window is ready' and focus the window instead.
    gnomeExtensions.eye-on-cursor # eyes!

    gnome-characters # Emoji table.
    gnome-tweaks
  ];
}
