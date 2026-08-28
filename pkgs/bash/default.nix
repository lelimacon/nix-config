{
  pkgs,
  wrappers,
  starship,
  ...
}:
let
  loadFileIfExists = path: "[ -f ${path} ] && . ${path}";
  package = pkgs.bashInteractive;
in
import ./lib.nix
{
  inherit package pkgs wrappers;

  # Bash configuration, shaped like home-manager's `programs.bash` options
  # (historyControl, historyFileSize, historySize, shellOptions,
  # shellAliases, initExtra) — rendered to the actual rc file in lib.nix.
  settings =
  {
    historyControl = [ "erasedups" ];
    historyFileSize = 20000;
    historySize = 10000;

    shellOptions =
    [
      "histappend"
      "extglob"
      "globstar"
      "checkjobs"
    ];

    # Custom aliases.
    # Aliases from `environment.shellAliases` will be sourced automatically.
    shellAliases =
    {
    };

    initExtra =
    ''
      if [[ ! -v BASH_COMPLETION_VERSINFO ]]; then
        . "${pkgs.bash-completion}/etc/profile.d/bash_completion.sh"
      fi

      if [[ :$SHELLOPTS: =~ :(vi|emacs): ]]; then
        eval "$(${pkgs.fzf}/bin/fzf --bash)"
      fi

      SHELL=${package}/bin/bash

      # Load private bashrc if found.
      ${loadFileIfExists "$HOME/.private.bashrc"}

      source <(${pkgs.carapace}/bin/carapace _carapace bash)

      if [[ $TERM != "dumb" ]]; then
        eval "$(${starship}/bin/starship init bash --print-full-init)"
      fi
    '';
  };
}
