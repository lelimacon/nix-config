/*
Bash, wrapped to always load a Nix-generated rc file instead of `~/.bashrc`.

No dedicated bash module exists in nix-wrapper-modules, so this uses the
generic `wrapPackage` and forces the rc file via `--rcfile`.

Known issue: `--rcfile` only applies to interactive, non-login shells — a
login shell (e.g. some terminal defaults) would fall back to sourcing
/etc/profile and ~/.bash_profile instead, skipping this file entirely.
*/
{
  pkgs,
  wrappers,
  starship,
  ...
}:
let
  lib = pkgs.lib;
  settings = import ./settings.nix { inherit pkgs starship; };

  # History and the rc file itself live here instead of $HOME directly.
  configDir = "$HOME/.config/bash-nix-wrapper";

  # Renders the home-manager-shaped settings above into an actual rc file.
  bashrc = ''
    # Commands that should be applied only for interactive shells.
    [[ $- == *i* ]] || return

    HISTFILE=${configDir}/history
    HISTCONTROL=${lib.concatStringsSep ":" settings.historyControl}
    HISTFILESIZE=${toString settings.historyFileSize}
    HISTSIZE=${toString settings.historySize}

    ${lib.concatMapStrings (opt: "shopt -s ${opt}\n") settings.shellOptions}
    ${lib.concatStrings (lib.mapAttrsToList (name: value: "alias -- ${name}=${lib.escapeShellArg value}\n") settings.shellAliases)}
    ${settings.initExtra}
  '';

  rcFile = pkgs.writeText "bashrc" bashrc;
in
wrappers.lib.wrapPackage ({ lib, ... }:
{
  inherit pkgs;
  package = pkgs.bashInteractive;

  # esc-fn = lib.id skips shell quoting so $HOME expands at runtime.
  addFlag =
  [
    {
      data = [ "--rcfile" "${configDir}/bashrc" ];
      esc-fn = lib.id;
    }
  ];

  runShell =
  [
    ''
      mkdir -p "${configDir}"

      # Link bashrc for easy access.
      ln -sf "${rcFile}" "${configDir}/bashrc"

      # Log timestamp.
      date -u '+%Y-%m-%dT%H:%M:%SZ' > "${configDir}/last-run.txt"
    ''
  ];
})
