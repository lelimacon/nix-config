/*
Firefox browser configuration.

Known issues :
- Screensharing not working
*/
{
  config, # for customization, not yet used.
  pkgs,
  wrappers,
}:
let
  inherit (import ../../lib/shell.nix) gitEnsureRepo gitCommit syncSettings;
  inherit (import ../../lib/wrapping.nix { inherit pkgs; }) wrapIfMacOsApp;

  lib = pkgs.lib;

  policies = import ./policies.nix;
  settings = import ./settings.nix;

  firefox = pkgs.firefox.override
  {
    extraPolicies = policies;
  };

  configDir = "$HOME/.config/Firefox-profile-nix-wrapper";

  mkUserJs = settings: pkgs.writeText "user.js" (lib.concatStrings (
    lib.mapAttrsToList (name: value: ''
      user_pref(${builtins.toJSON name}, ${builtins.toJSON value});
    '') settings
  ));

  generatedDir = pkgs.linkFarm "firefox-profile" [
    { name = "user.js";                path = mkUserJs settings; }
    { name = "chrome/userChrome.css";  path = ./userChrome.css; }
    { name = "chrome/userContent.css"; path = ./userContent.css; }
  ];

  wrapped = wrappers.lib.wrapPackage ({ lib, ... }:
  {
    inherit pkgs;
    package = firefox;

    # On Darwin, pkgs.firefox ships only Applications/Firefox.app — there's
    # no top-level bin/firefox for wrapPackage's default (bin/<name>) guess
    # to find, which is what made it point at a nonexistent path.
    exePath = lib.mkIf
        pkgs.stdenv.isDarwin
        "Applications/Firefox.app/Contents/MacOS/firefox";

    # Point Firefox at a fixed profile dir regardless of profiles.ini.
    # esc-fn = lib.id skips shell quoting so $HOME expands at runtime.
    addFlag =
    [
      {
        data = [ "-profile" configDir ];
        esc-fn = lib.id;
      }
    ];

    runShell =
    [
      (gitEnsureRepo configDir "${./.gitignore}")
      (gitCommit configDir "before")
      (syncSettings "${generatedDir}" configDir)
      (gitCommit configDir "after")
    ];
  });
in
(wrapIfMacOsApp "Firefox" "firefox" wrapped) // { withoutAppBundle = wrapped; }
