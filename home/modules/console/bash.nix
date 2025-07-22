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

    # Dev shells.
    "dev-builder" = "nix develop path:${toString ../../../shells/gtk}    --command gnome-builder";
    "dev-rider"   = "nix develop path:${toString ../../../shells/dotnet} --command rider";
    "dev-rover"   = "nix develop path:${toString ../../../shells/rust}   --command rust-rover";
    "dev-unity"   = "nix develop path:${toString ../../../shells/dotnet} --command unityhub";

    # Scripts.
    "dirt" = toString ../../../ext/scripts/dirt.sh;
    "what" = toString ../../../ext/scripts/what.sh;
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
      STORE_ROOT=${toString ../../..}

      # Load private bashrc if found.
      ${loadFileIfExists("$HOME/.private.bashrc")}
    '';
  };
}
