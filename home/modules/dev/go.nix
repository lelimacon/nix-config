# Golang.
{
  pkgs,
  pkgs-wrappers,
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
    pkgs-wrappers.goland
  ];
}
