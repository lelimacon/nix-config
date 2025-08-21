{
  config,
  pkgs,
  ...
}:
let
  theme =
  {
    name = "adw-gtk3";
    package = pkgs.adw-gtk3;
  };
  font =
  {
    name = "Ubuntu Nerd Font";
    package = pkgs.ubuntu-sans;
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
    #x11.enable = true;
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
}
