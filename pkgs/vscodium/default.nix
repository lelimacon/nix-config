{
  config,
  pkgs,
  wrappers,
}:
let
  inherit (import ../../lib/shell.nix) gitEnsureRepo gitCommit syncSettings;
  inherit (import ../../lib/wrapping.nix { inherit pkgs; }) wrapIfMacOsApp;

  lib = pkgs.lib;

  settings = import ./settings.nix { inherit config lib pkgs; };
  keybindings = import ./keybindings.nix;

  version = lib.versions.majorMinor pkgs.vscodium.version;
  configDir = "$HOME/.config/VSCodium.${version}";
  hardcodedDir = toString ./hardcoded-settings;

  fmt = json: pkgs.runCommand "fmt.json" { } ''
    ${pkgs.jq}/bin/jq . ${pkgs.writeText "raw.json" (builtins.toJSON json)} > $out
  '';

  generatedDir = pkgs.linkFarm "vscodium-settings" [
    { name = "User/settings.json";    path = fmt settings; }
    { name = "User/keybindings.json"; path = fmt keybindings; }
  ];
in
wrapIfMacOsApp "VSCodium" "codium"
(wrappers.lib.wrapPackage ({ lib, ... }:
  {
    inherit pkgs;
    package = pkgs.vscodium;
    addFlag =
    [
      {
        data = "--user-data-dir=${configDir}";
        esc-fn = lib.id;
      }
    ];
    # GUI-launched apps (Dock, Spotlight, Finder) don't inherit a login
    # shell's PATH, so extensions that shell out to tools (nushell, nix,
    # etc.) can't find them. Prefix the same paths a login shell would have.
    prefixVar =
    [
      [ "PATH" ":" "/run/current-system/sw/bin:/etc/profiles/per-user/${config.user.name}/bin:/nix/var/nix/profiles/default/bin" ]
    ];
    runShell =
    [
      (gitEnsureRepo configDir "${hardcodedDir}/.gitignore")
      (gitCommit configDir "before")
      (syncSettings "${hardcodedDir}" configDir)
      (syncSettings "${generatedDir}" configDir)
      (gitCommit configDir "after")
    ];
  }))
