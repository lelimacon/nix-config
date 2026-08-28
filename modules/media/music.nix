{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs;
  [
    spotify psst # music clients.
  ];
}
