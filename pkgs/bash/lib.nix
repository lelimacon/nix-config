/*
Bash shell configuration.

Known issue: `--rcfile` only applies to interactive, non-login shells — a
login shell (e.g. some terminal defaults) would fall back to sourcing
/etc/profile and ~/.bash_profile instead, skipping this file entirely.
*/
{
  pkgs,
  wrappers,
  settings,
}:
let
  lib = pkgs.lib;

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
