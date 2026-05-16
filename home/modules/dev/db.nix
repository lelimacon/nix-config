{
  pkgs,
  pkgs-unstable,
  ...
}:
{
  home.packages = with pkgs;
  [
    pkgs-unstable.jetbrains.datagrip
    #dbeaver-bin
  ];
}
