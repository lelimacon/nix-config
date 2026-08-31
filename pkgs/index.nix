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

  jetbrains-goland = import ./jetbrains-goland { inherit config pkgs pkgs-unstable wrappers; };
  jetbrains-idea = import ./jetbrains-idea { inherit config pkgs pkgs-unstable wrappers; };
  jetbrains-datagrip = import ./jetbrains-datagrip { inherit config pkgs pkgs-unstable wrappers; };
  jetbrains-webstorm = import ./jetbrains-webstorm { inherit config pkgs pkgs-unstable wrappers; };
  jetbrains-rider = import ./jetbrains-rider { inherit config pkgs pkgs-unstable wrappers; };
  jetbrains-rust-rover = import ./jetbrains-rust-rover { inherit config pkgs pkgs-unstable wrappers; };

  kitty = import ./kitty { inherit config pkgs wrappers; };
  vscodium = import ./vscodium { inherit config pkgs wrappers; };
  firefox = import ./firefox { inherit config pkgs wrappers; };
}
// pkgs.lib.optionalAttrs pkgs.stdenv.isDarwin
{
  netpad = pkgs.callPackage ./netpad { };
}
