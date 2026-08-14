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
    export GOROOT="${pkgs.go}/share/go"

    export GO_VERSION="$(go version | cut -c14-)"
    export GOVULN_VERSION="$(govulncheck --version 2>&1 | awk '/^Scanner:/{split($2,a,"@"); v=a[2]} /^DB updated:/{sub(/^DB updated: /,""); print v " — " $0}')"
    export CLANG_VERSION="$(clang --version 2>&1 | awk 'NR==1{sub(/.*version /, ""); v=$0} NR==2{sub(/Target: /, ""); print v " " $0}')"

    export CC="${pkgs.clang}/bin/clang"
    export CGO_CFLAGS="--sysroot=$(xcrun --show-sdk-path)"
    export CGO_LDFLAGS="--sysroot=$(xcrun --show-sdk-path)"

    echo "Go      $GO_VERSION"
    echo "Govuln  $GOVULN_VERSION"
    echo "Clang   $CLANG_VERSION"
  '';
}
