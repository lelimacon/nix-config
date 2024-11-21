{
  description = "Desktop widgets with Astal";

  inputs =
  {
    astal =
    {
      url = "github:aylur/astal";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils.url = "github:numtide/flake-utils";

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
  {
    self,
    astal,
    flake-utils,
    nixpkgs,
  }:
  flake-utils.lib.eachDefaultSystem (system: {
    packages.default =
    let
      pkgs = import nixpkgs { system = system; };
    in
    pkgs.stdenv.mkDerivation(
    {
      name = "drawernator";
      src = ./.;

      nativeBuildInputs = with pkgs;
      [
        meson
        ninja
        pkg-config
        vala
        gobject-introspection
        dart-sass
      ];

      buildInputs =
      [
        astal.packages.${system}.io
        astal.packages.${system}.astal3
        astal.packages.${system}.battery
        astal.packages.${system}.wireplumber
        astal.packages.${system}.network
        astal.packages.${system}.tray
        astal.packages.${system}.mpris
        astal.packages.${system}.hyprland
      ];
    });
  });
}
