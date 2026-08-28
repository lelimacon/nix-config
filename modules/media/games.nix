{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs;
  [
    xmoto
  ];
}
