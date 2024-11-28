{
  pkgs,
  ...
}:
let
  loadFileIfExists = path: "[ -f ${path} ] && . ${path}";

  aliases =
  {
    ".." = "cd ..";
    "..." = "cd ../..";

    "l" = "eza";
    "ll" = "eza -l --icons";
    "tree" = "eza --tree";

    "code" = "codium";

    # Scripts.
    "dirt" = "~/scripts/dirt.sh";
    "what" = "~/scripts/what.sh";
  };
in
{
  programs.bash =
  {
    enable = true;

    shellAliases = aliases;

    historyControl = [ "erasedups" ]; # erase previous duplicate entries.
    historyFileSize = 20000;

    initExtra =
    ''
      SHELL=${pkgs.bash}

      # Load private bashrc if found.
      ${loadFileIfExists("$HOME/.bashrc_private")}
    '';
  };
}
