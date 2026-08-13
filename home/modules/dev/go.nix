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
    golangci-lint # linter.
    govulncheck # vulnerability database.

    # IDE.
    pkgs-unstable.jetbrains.goland
  ];
}
