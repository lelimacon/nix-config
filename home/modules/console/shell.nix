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
