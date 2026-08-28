{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs;
  [
    # Wine.
    bottles # WINE prefix manager.
  ];
}
