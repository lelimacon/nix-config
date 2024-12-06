{
  description = "Desktop widgets with Astal";

  inputs =
  {
    astal =
    {
      url = "github:aylur/astal";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils =
    {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };

    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

    systems.url = "github:nix-systems/x86_64-linux";
  };

  outputs =
  {
    astal,
    flake-utils,
    nixpkgs,
    self,
    ...
  }:
  flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs
      {
        system = system;
      };
      nativeBuildInputs = with pkgs;
      [
        vala # language.
        dart-sass # scss, css preprocessor.
        #glib # GNOME core library.
        gobject-introspection # GObject bindings for other languages (e.g. Vala).
        meson ninja pkg-config # build tools.
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
    in
    {
      packages.default = pkgs.stdenv.mkDerivation
      {
        name = "drawernator";
        src = ./.;
        nativeBuildInputs = nativeBuildInputs;
        buildInputs = buildInputs;
      };

      # To run GNOME Builder :
      # $ nix develop --command gnome-builder --project .
      devShells.default = pkgs.mkShell
      {
        nativeBuildInputs = nativeBuildInputs;
        buildInputs = buildInputs;
      };
    }
  );
}
