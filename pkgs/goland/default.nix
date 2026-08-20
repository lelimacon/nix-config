{
  config, # for customization, not yet used.
  pkgs,
  pkgs-unstable,
  wrappers,
  ...
}:
let
  goland = pkgs-unstable.jetbrains.goland;
  version = pkgs.lib.versions.majorMinor goland.version;
  configDir = "$HOME/.config/JetBrains.GoLand.${version}";
  settingsDir = toString ./settings;

  # Ensures the dir exists and the git repo is initialized.
  # Copies .gitignore from `gitignoreSrc` before the first init so ignored
  # files are never staged in the initial commit.
  gitEnsureRepo = dir: gitignoreSrc:
  ''
    mkdir -p "${dir}"
    if [ ! -d "${dir}/.git" ]; then
      [ -f "${gitignoreSrc}" ] && cp -f "${gitignoreSrc}" "${dir}/.gitignore"
      git -C "${dir}" init --quiet
    fi
  '';

  # Stages everything and commits if anything changed.
  gitCommit = dir: label:
  ''
    (
      GIT="git -C ${dir}"
      $GIT add -A
      $GIT diff --cached --quiet || \
        $GIT commit --quiet -m "$(date -u '+%Y-%m-%dT%H:%M:%SZ') ${label}"
    )
  '';

  # Generates a shell snippet that syncs every file from `src` into `dst`,
  # always overwriting. Uses find so dotfiles are included.
  syncSettings = src: dst:
  ''
    if [ -d "${src}" ]; then
      while IFS= read -r file; do
        rel="''${file#${src}/}"
        target="${dst}/$rel"
        mkdir -p "$(dirname "$target")"
        cp -f "$file" "$target"
      done < <(find "${src}" -type f -not -name ".gitkeep")
    fi
  '';
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
