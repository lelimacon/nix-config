# Index of all custom packages.
{
  pkgs,
}:
let
  nuScript = name: path: pkgs.writeShellApplication
  {
    name = name;
    runtimeInputs = [pkgs.nushell];
    text = ''nu ${path} "$@"'';
  };
in
{
  shelve = import ./shelve/default.nix { inherit pkgs; };

  # Scripts.
  develop = nuScript "develop" ./scripts/develop.nu;
  where = nuScript "where" ./scripts/where.nu;
  dirt = nuScript "dirt" ./scripts/dirt.nu;
}
