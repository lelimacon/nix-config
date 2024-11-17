{
  config,
  pkgs,
  ...
}:
let
  nerdfonts = pkgs.nerdfonts.override
  {
    fonts =
    [
      "Ubuntu"
      "UbuntuMono"
    ];
  };

  theme =
  {
    name = "adw-gtk3";
    package = pkgs.adw-gtk3;
  };
  font =
  {
    name = "Ubuntu Nerd Font";
    package = nerdfonts;
    size = 11;
  };
  cursorTheme =
  {
    name = "Qogir";
    size = 24;
    package = pkgs.qogir-icon-theme;
  };
  iconTheme =
  {
    name = "MoreWaita";
    package = pkgs.morewaita-icon-theme;
    #name = "Flat-Remix-GTK-Grey-Darkest";
    #package = pkgs.flat-remix-gtk;
  };
in
{
  home.packages = with pkgs;
  [
    theme.package
    font.package
    cursorTheme.package
    iconTheme.package
  ];

  home.pointerCursor =
  {
    gtk.enable = true;
    # x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
  };

  gtk =
  {
    inherit font cursorTheme iconTheme;

    enable = true;

    gtk3.extraConfig =
    {
      # Gtk-WARNING: Unknown key Settings in ~/.config/gtk-3.0/settings.ini
      #Settings = ''
      #  gtk-application-prefer-dark-theme=1
      #'';
    };

    gtk4.extraConfig =
    {
      #Settings = ''
      #  gtk-application-prefer-dark-theme=1
      #'';
    };
  };

  # `dconf watch /` to track changes.
  #dconf.settings =
  #{
  #  "org/gtk/gtk4/settings/file-chooser" =
  #  {
  #    show-hidden = true; # show hidden files.
  #  };
  #  "org/gnome/shell" =
  #  {
  #    favorite-apps =
  #    [
  #      "firefox.desktop"
  #      "org.gnome.Nautilus.desktop"
  #      "org.telegram.desktop.desktop"
  #      "org.gnome.Console.desktop"
  #    ];
  #  };
  #  "org/gnome/desktop/interface" =
  #  {
  #    color-scheme = "default"; # light with dark appbar.
  #    enable-hot-corners = false; # no flicking to the top-left corner.
  #    gtk-enable-primary-paste = false; # no pasting with mouse middle click.
  #  };
  #  "org/gnome/desktop/wm/preferences" =
  #  {
  #    workspace-names = [ "Main" ];
  #  };
  #  "org/gnome/desktop/background" =
  #  {
  #    picture-uri = "file:///home/lelimacon/Pictures/pixel-black.png";
  #    picture-options = "stretched";
  #    #primary-color = "#000000";
  #    #secondary-color = "#000000";
  #  };
  #};
}
