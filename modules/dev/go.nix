# Golang.
{
  pkgs,
  pkgs-wrappers,
  ...
}:
{
  environment.systemPackages = with pkgs;
  [
    go
    gopls # official language server.
    golangci-lint # linter.
    govulncheck # vulnerability database.

    # IDE.
    pkgs-wrappers.jetbrains-goland
  ];
}
