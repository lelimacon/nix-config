{
  pkgs,
  ...
}:
{
  home.packages = with pkgs;
  [
    # Wine.
    bottles # WINE prefix manager.
  ];
}
