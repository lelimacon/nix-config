{
  pkgs-ext,
  ...
}:
{
  environment.systemPackages =
  [
    pkgs-ext.develop
    pkgs-ext.dirt
    pkgs-ext.shelve
    pkgs-ext.what
    pkgs-ext.where
  ];
}
