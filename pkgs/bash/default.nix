{
  pkgs,
  wrappers,
  starship,
  ...
}:
let
  loadFileIfExists = path: "[ -f ${path} ] && . ${path}";
in
import ./lib.nix
{
  inherit pkgs wrappers;

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

    shellAliases =
    {
      ".." = "cd ..";
      "..." = "cd ../..";
      "dev" = "develop ${toString ../..}";
      "dev-builder" = "nix develop path:${toString ../../shells/gtk}    --command gnome-builder";
      "dev-rider"   = "nix develop path:${toString ../../shells/dotnet} --command rider";
      "dev-rover"   = "nix develop path:${toString ../../shells/rust}   --command rust-rover";
      "dev-unity"   = "nix develop path:${toString ../../shells/dotnet} --command unityhub";
      "gl" = "git log --graph --pretty=format:'%Cgreen%ad%Creset %C(auto)%h %s %C(bold black)<%aN>%C(auto)%d%Creset' --date=format-local:'%Y-%m-%d %H:%M'";
      "l" = "eza";
      "ll" = "eza -l --icons";
      "nix-dirt" = "dirt --dir ~/.config --verbosity files";
      "nix-graph" = "nix-du -s=500MB | dot -Tsvg > store.svg";
      "tree" = "eza --tree";
      "what" = toString ../../ext/scripts/what.sh;
    };

    initExtra =
    ''
      if [[ ! -v BASH_COMPLETION_VERSINFO ]]; then
        . "${pkgs.bash-completion}/etc/profile.d/bash_completion.sh"
      fi

      if [[ :$SHELLOPTS: =~ :(vi|emacs): ]]; then
        eval "$(${pkgs.fzf}/bin/fzf --bash)"
      fi

      SHELL=${pkgs.bashInteractive}/bin/bash

      # Load private bashrc if found.
      ${loadFileIfExists "$HOME/.private.bashrc"}

      source <(${pkgs.carapace}/bin/carapace _carapace bash)

      if [[ $TERM != "dumb" ]]; then
        eval "$(${starship}/bin/starship init bash --print-full-init)"
      fi
    '';
  };
}
