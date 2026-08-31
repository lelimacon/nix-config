{
  pkgs,
  pkgs-wrappers,
  ...
}:
{
  environment.systemPackages = with pkgs;
  [
    pkgs-wrappers.jetbrains-datagrip
    #dbeaver-bin
  ];
}
