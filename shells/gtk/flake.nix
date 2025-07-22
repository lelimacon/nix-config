{
  description = "GTK shell";

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
    in
    {
      # To run GNOME Builder :
      # $ nix develop --command gnome-builder
      devShells.default = pkgs.mkShell
      {
        buildInputs = with pkgs;
        [
          gnome-builder # IDE.
          vala # language.
          dart-sass # scss, css preprocessor.
          #glib # GNOME core library.
          gobject-introspection # GObject bindings for other languages (e.g. Vala).
          meson ninja pkg-config # build tools.

          # Astal toolkit.
          astal.packages.${system}.io
          astal.packages.${system}.astal3
          astal.packages.${system}.battery
          astal.packages.${system}.wireplumber
          astal.packages.${system}.network
          astal.packages.${system}.tray
          astal.packages.${system}.mpris
          astal.packages.${system}.hyprland
        ];
      };
    }
  );
}
