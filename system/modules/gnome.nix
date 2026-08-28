{
  lib,
  pkgs,
  ...
}:
let
  dconfSettings =
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
        (lib.gvariant.mkTuple ["xkb" "fr"])
        (lib.gvariant.mkTuple ["xkb" "br"])
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
in
{
  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # Enable dconf.
  programs.dconf.enable = true;
  programs.dconf.profiles.user.databases =
  [
    { settings = dconfSettings; }
  ];

  # Remove all default apps.
  # Some may be added back in home manager.
  environment.gnome.excludePackages = with pkgs;
  [
    cheese # webcam.
    epiphany # web browser.
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

  # Generic apps.
  environment.systemPackages = with pkgs;
  [
    # Utils.
    pavucontrol # PulseAudio Volume Control.
    mission-center # activity monitor.
    #rustdesk # remote desktop sharing (OSS alternative to AnyDesk).

    # GNOME shell extensions.
    # https://extensions.gnome.org/
    # Enabled above in the dconf settings.
    gnomeExtensions.appindicator # AppIndicator and KStatusNotifierItem support.
    gnomeExtensions.dash-to-panel # Windows-style taskbar.
    gnomeExtensions.just-perfection # tweak tool.
    gnomeExtensions.space-bar # better workspaces indicator.
    gnomeExtensions.user-themes # User Themes.
    gnomeExtensions.vitals # system information.
    gnomeExtensions.steal-my-focus-window # remove 'window is ready' and focus the window instead.

    gnome-characters # Emoji table.
    gnome-tweaks
  ];
}
