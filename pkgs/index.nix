# Index of wrapped packages (via nix-wrapper-modules).
# Merged with ext/index.nix packages in flake.nix as pkgs-local.
{
  pkgs,
  pkgs-unstable,
  wrappers,
}:
let
  starship = import ./starship { inherit pkgs wrappers; };
in
{
  inherit starship;
  nushell = import ./nushell { inherit pkgs wrappers starship; };
  goland = import ./goland { inherit pkgs pkgs-unstable wrappers; };
}
