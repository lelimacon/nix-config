{
  config, # for customization, not yet used.
  pkgs,
  pkgs-unstable,
  wrappers,
  ...
}:
let
  inherit (import ../helpers.nix) gitEnsureRepo gitCommit syncSettings;

  goland = pkgs-unstable.jetbrains.goland;
  version = pkgs.lib.versions.majorMinor goland.version;
  configDir = "$HOME/.config/JetBrains.GoLand.${version}";
  settingsDir = toString ./settings;
in
wrappers.lib.wrapPackage ({ lib, ... }:
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
    (gitEnsureRepo configDir "${settingsDir}/.gitignore")
    (gitCommit configDir "before")
    (syncSettings settingsDir configDir)
    (gitCommit configDir "after")
  ];
})
