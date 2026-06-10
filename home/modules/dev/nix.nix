{
  pkgs,
  ...
}:
{
  home.packages = with pkgs;
  [
    nixd # Nix language server.
  ];
}
