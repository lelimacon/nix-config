# Golang.
{
  pkgs,
  pkgs-unstable,
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
