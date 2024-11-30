{
  lib,
  ...
}:
let
  mkTuple = lib.hm.gvariant.mkTuple;
in
{
  # `dconf watch /` to track changes.
  dconf.settings =
  {
    "org/gtk/gtk4/settings/file-chooser" =
    {
      show-hidden = true; # show hidden files.
    };

    "org/gnome/settings-daemon/plugins/power" =
    {
      # Automatic suspend when plugged in.
      sleep-inactive-ac-type = "nothing"; # never suspend.
      sleep-inactive-ac-timeout = 60 * 20; # 20 min.

      # Automatic suspend on battery.
      sleep-inactive-battery-type = "suspend";
      sleep-inactive-battery-timeout = 60 * 20; # 20 min.
    };

    "org/gnome/shell" =
    {
      disable-user-extensions = false;

      # `gnome-extensions list` for a list.
      enabled-extensions =
      [
        "appindicatorsupport@rgcjonas.gmail.com"
        #"dash-to-panel@jderose9.github.com"
        #"just-perfection-desktop@just-perfection"
        #"space-bar@luchrioh"
        "user-theme@gnome-shell-extensions.gcampax.github.com"
        "Vitals@CoreCoding.com"
        "steal-my-focus-window@steal-my-focus-window"
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

    "org/gnome/desktop/background" =
    {
      picture-uri = "file:///home/lelimacon/Pictures/pixel-black.png";
      picture-options = "stretched";
      #primary-color = "#000000";
      #secondary-color = "#000000";
    };

    "org/gnome/desktop/input-sources" =
    {
      sources =
      [
        (mkTuple ["xkb" "fr"])
        (mkTuple ["xkb" "br"])
      ];
    };

    "org/gnome/desktop/interface" =
    {
      color-scheme = "default"; # light with dark appbar.
      edge-tiling = true; # drag windows against screen edges to rezise.
      enable-hot-corners = false; # flicking top-left corner for activities overview.
      gtk-enable-primary-paste = false; # no pasting with mouse middle click.
    };

    "org/gnome/desktop/peripherals/mouse" =
    {
      speed = -0.6;
      natural-scroll = false;
    };

    "org/gnome/desktop/session" =
    {
      # TODO: Does not work.
      #idle-delay = lib.gvariant.mkInt32 0; # never turn the screen off.
      #idle-delay = lib.gvariant.mkInt32 (60 * 15); # 15 min.
    };

    "org/gnome/desktop/wm/preferences" =
    {
      button-layout = "appmenu:minimize,close";
      workspace-names = [ "Main" ];
    };
  };
}
