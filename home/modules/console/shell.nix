# Generic shell configuration.
{
  ...
}:
{
  home.shellAliases =
  {
    ".." = "cd ..";
    "..." = "cd ../..";

    "l" = "eza";
    "ll" = "eza -l --icons";
    "tree" = "eza --tree";

    # Git.
    # Git log formatting: https://gist.github.com/niun/ca61a37791ff1fdc9b33
    "gl" = "git log --all --graph --pretty=format:'%Cgreen%ad%Creset %C(auto)%h %s %C(bold black)<%aN>%C(auto)%d%Creset' --date=format-local:'%Y-%m-%d %H:%M'";

    # Dev shells.
    "dev" = "develop ${toString ../../..}";
    "dev-builder" = "nix develop path:${toString ../../../shells/gtk}    --command gnome-builder";
    "dev-rider"   = "nix develop path:${toString ../../../shells/dotnet} --command rider";
    "dev-rover"   = "nix develop path:${toString ../../../shells/rust}   --command rust-rover";
    "dev-unity"   = "nix develop path:${toString ../../../shells/dotnet} --command unityhub";

    # Scripts.
    "dirt" = toString ../../../ext/scripts/dirt.sh;
    "what" = toString ../../../ext/scripts/what.sh;
  };

  # Some (manual) installs are in _unconventional_ locations.
  home.sessionPath =
  [
    "$HOME/.local/bin"
  ];
}
