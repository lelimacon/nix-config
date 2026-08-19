# Golang.
{
  pkgs,
  pkgs-local,
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
    pkgs-local.goland
  ];
}
