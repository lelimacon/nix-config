{
  pkgs-ext,
  ...
}:
{
  home.packages =
  [
    pkgs-ext.develop
    pkgs-ext.dirt
    pkgs-ext.shelve
    pkgs-ext.what
    pkgs-ext.where
  ];
}
