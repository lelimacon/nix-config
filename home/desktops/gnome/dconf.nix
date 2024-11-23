{
  ...
}:
{
  # `dconf watch /` to track changes.
  dconf.settings =
  {
    "org/gtk/gtk4/settings/file-chooser" =
    {
      show-hidden = true; # show hidden files.
    };

    "org/gnome/shell" =
    {
      disable-user-extensions = false;

      # `gnome-extensions list` for a list.
      enabled-extensions =
      [
        "appindicatorsupport@rgcjonas.gmail.com"
        #"dash-to-panel@jderose9.github.com"
        "sound-output-device-chooser@kgshank.net"
        #"space-bar@luchrioh" # Better workspaces indicator.
        "trayIconsReloaded@selfmade.pl"
        "user-theme@gnome-shell-extensions.gcampax.github.com" # User Themes.
        "Vitals@CoreCoding.com"
      ];

      # Pinned apps.
      favorite-apps =
      [
        "firefox.desktop"
        "org.gnome.Nautilus.desktop"
        "org.telegram.desktop.desktop"
        "org.gnome.Console.desktop"
      ];
    };

    "org/gnome/desktop/interface" =
    {
      color-scheme = "default"; # light with dark appbar.
      enable-hot-corners = false; # no flicking to the top-left corner.
      gtk-enable-primary-paste = false; # no pasting with mouse middle click.
    };

    "org/gnome/desktop/wm/preferences" =
    {
      button-layout = "appmenu:minimize,close";
      workspace-names = [ "Main" ];
    };

    "org/gnome/desktop/background" =
    {
      picture-uri = "file:///home/lelimacon/Pictures/pixel-black.png";
      picture-options = "stretched";
      #primary-color = "#000000";
      #secondary-color = "#000000";
    };
  };
}
