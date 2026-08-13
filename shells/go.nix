{
  pkgs,
  ...
}:
pkgs.mkShell
{
  description = "Golang.";

  buildInputs = with pkgs;
  [
    go
    gopls # official language server.
    golangci-lint # linter.
    govulncheck # vulnerability database.

    # Lib dependencies.
    clang
  ];

  shellHook =
  ''
    export GO_SDK_HOME="${pkgs.go}/lib/go"

    export GO_VERSION="$(go version | cut -c14-)"

    export CC="${pkgs.clang}/bin/clang"
    export CGO_CFLAGS="--sysroot=$(xcrun --show-sdk-path)"
    export CGO_LDFLAGS="--sysroot=$(xcrun --show-sdk-path)"

    echo "Go  $GO_VERSION"
  '';
}
