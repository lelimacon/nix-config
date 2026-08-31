{
  config,
  pkgs,
  pkgs-unstable,
  wrappers,
  ...
}:
import ./lib.nix
{
  inherit pkgs wrappers;

  package = pkgs-unstable.jetbrains.goland;

  env =
  {
    GOROOT = "${pkgs.go}/share/go";
    CC = "${pkgs.clang}/bin/clang";
  };

  # TODO: Take these packages from the go shell?
  runtimePkgs = with pkgs;
  [
    go
    gopls
    golangci-lint
    govulncheck
    clang
    git
  ];

  settings =
  {
    # JetBrains' font isn't ligature-aware, so it needs the "frozen" font variant.
    fonts =
    {
      fontFamily = config.theme.monoFont.frozenFamily;
      useLigatures = true;
    };

    themeId = "Islands Light";
    colorScheme = "Light";

    editor =
    {
      stripTrailingSpaces = "Whole";
      keepTrailingSpaceOnCaretLine = false;
    };
  };
}
