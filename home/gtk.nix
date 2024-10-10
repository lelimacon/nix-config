{
  config,
  pkgs,
  ...
}:
{
  gtk =
  {
    enable = true;

    #iconTheme =
    #{
    #  name = "Papirus-Dark";
    #  package = pkgs.papirus-icon-theme;
    #};

    #theme =
    #{
    #  name = "palenight";
    #  package = pkgs.palenight-theme;
    #};

    cursorTheme =
    {
      name = "Numix-Cursor";
      package = pkgs.numix-cursor-theme;
    };

    gtk3.extraConfig =
    {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };

    gtk4.extraConfig =
    {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };

  # `dconf watch /` to track changes.
  dconf.settings =
  {
    "org/gtk/gtk4/settings/file-chooser" =
    {
      show-hidden = true; # show hidden files.
    };
    "org/gnome/shell" =
    {
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
