# Golang.
{
  pkgs,
  ...
}:
{
  home.packages = with pkgs;
  [
    go
    gopls # official language server.

    # IDE.
    pkgs-unstable.jetbrains.goland
  ];
}
