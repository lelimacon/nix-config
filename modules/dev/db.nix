{
  pkgs,
  pkgs-unstable,
  ...
}:
{
  environment.systemPackages = with pkgs;
  [
    pkgs-unstable.jetbrains.datagrip
    #dbeaver-bin
  ];
}
