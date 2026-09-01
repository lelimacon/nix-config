{
  pkgs,
  pkgs-wrappers,
  ...
}:
{
  environment.systemPackages = with pkgs;
  [
    pkgs-wrappers.jetbrains-datagrip
    pkgs-wrappers.netpad
    #dbeaver-bin
  ];
}
