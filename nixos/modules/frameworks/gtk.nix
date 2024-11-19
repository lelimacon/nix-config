{
  pkgs,
  pkgs-stable,
  ...
}:
{
  environment.systemPackages = with pkgs;
  [
    gtk3 gtk4 # for `gtk4-icon-browser`.
    vala
  ];
}
