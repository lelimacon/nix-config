# Index of wrapped packages (via nix-wrapper-modules).
# Merged with ext/_.nix packages in flake.nix as pkgs-local.
{
  pkgs,
  wrappers,
}:
{
  starship = import ./starship { inherit pkgs wrappers; };
}
