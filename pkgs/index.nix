# Index of wrapped packages (via nix-wrapper-modules).
{
  config,
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
  bash = import ./bash { inherit pkgs wrappers starship; };
  git = import ./git { inherit pkgs wrappers; };
  goland = import ./goland { inherit config pkgs pkgs-unstable wrappers; };
  kitty = import ./kitty { inherit config pkgs wrappers; };
  vscodium = import ./vscodium { inherit config pkgs wrappers; };
  firefox = import ./firefox { inherit config pkgs wrappers; };

  netpad = pkgs.callPackage ./netpad { };
}
