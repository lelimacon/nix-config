{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs;
  [
    gtk3 gtk4 # for `gtk4-icon-browser`.
    icon-library

    # Development.
    vala
    gnome-builder # IDE.
  ];
}
