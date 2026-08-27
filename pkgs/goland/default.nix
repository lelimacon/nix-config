{
  config,
  pkgs,
  pkgs-unstable,
  wrappers,
  ...
}:
let
  inherit (import ../../lib/shell.nix) gitEnsureRepo gitCommit syncSettings;
  inherit (import ../../lib/wrapping.nix { inherit pkgs; }) wrapIfMacOsApp;

  goland = pkgs-unstable.jetbrains.goland;
  configDir = "$HOME/.config/JetBrains.GoLand-nix-wrapper";
  hardcodedDir = toString ./hardcoded-settings;

  settings = import ./settings.nix { inherit config; };

  generatedDir = pkgs.linkFarm "goland-settings"
  [
    { name = "options/editor-font.xml"; path = pkgs.writeText "editor-font.xml" settings.fonts; }
  ];
in
wrapIfMacOsApp "Goland" "goland"
(wrappers.lib.wrapPackage ({ lib, ... }:
{
  inherit pkgs;

  package = goland;

  # Pass config/plugins paths as JVM system properties.
  # esc-fn = lib.id skips shell quoting so $HOME expands at runtime.
  addFlag =
  [
    { data = "-Didea.config.path=${configDir}";          esc-fn = lib.id; }
    { data = "-Didea.plugins.path=${configDir}/plugins"; esc-fn = lib.id; }
  ];

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

  runShell =
  [
    ''
      export CGO_CFLAGS="--sysroot=$(xcrun --show-sdk-path 2>/dev/null)"
      export CGO_LDFLAGS="--sysroot=$(xcrun --show-sdk-path 2>/dev/null)"
    ''
    (gitEnsureRepo configDir "${hardcodedDir}/.gitignore")
    (gitCommit configDir "before")
    (syncSettings hardcodedDir configDir)
    (syncSettings "${generatedDir}" configDir)
    (gitCommit configDir "after")
  ];
}))
