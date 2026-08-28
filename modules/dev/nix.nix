{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs;
  [
    nixd # Nix language server.
  ];
}
