{
  pkgs-local,
  ...
}:
{
  home.packages =
  [
    pkgs-local.develop
    pkgs-local.where
    pkgs-local.shelve
  ];
}
