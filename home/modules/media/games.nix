{
  pkgs,
  ...
}:
{
  home.packages = with pkgs;
  [
    xmoto
  ];
}
