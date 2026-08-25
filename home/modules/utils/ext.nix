{
  pkgs-ext,
  ...
}:
{
  home.packages =
  [
    pkgs-ext.develop
    pkgs-ext.where
    pkgs-ext.shelve
    pkgs-ext.dirt
  ];
}
