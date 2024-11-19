{
  pkgs,
  ...
}:
let
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
    initExtra =
    ''
      SHELL=${pkgs.bash}
    '';
  };
}
