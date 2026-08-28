{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs;
  [
    musescore
  ];
}
