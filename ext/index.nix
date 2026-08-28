# Index of all custom packages.
{
  pkgs,
}:
let
  shellScript = name: path: pkgs.writeShellApplication
  {
    name = name;
    runtimeInputs = with pkgs; [ nix-index toybox which ];
    text = builtins.readFile path;
  };
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
  dirt = nuScript "dirt" ./scripts/dirt.nu;
  what = shellScript "what" ./scripts/what.sh;
  where = nuScript "where" ./scripts/where.nu;
}
