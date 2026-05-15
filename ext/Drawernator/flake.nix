{
  inputs =
  {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    astal =
    {
      url = "github:aylur/astal";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
  {
    self,
    nixpkgs,
    astal,
  }: let
    #system = "x86_64-linux";
    system = "aarch64-darwin";
    pkgs = nixpkgs.legacyPackages.${system};

    nativeBuildInputs = with pkgs;
    [
      meson
      ninja
      pkg-config
      gobject-introspection
      wrapGAppsHook4
      blueprint-compiler
      dart-sass
      vala
      #desktop-file-utils
    ];

    buildInputs = with pkgs;
    [
      gtk4
      glib
      #gtk4-layer-shell # linux only.
      #libadwaita # UI library.
      cmake
      #libnma # linux only.

      # For hiding the window.
      #darwin.apple_sdk.frameworks.Cocoa
      #darwin.apple_sdk.frameworks.AppKit
      apple-sdk
      #apple-sdk_26
    ];

    #astalPackages = with astal.packages.${system};
    #[
    #  astal4
    #  battery
    #  wireplumber
    #  network
    #  mpris
    #  powerprofiles
    #  tray
    #  bluetooth
    #];
  in {
    packages.${system}.default = pkgs.stdenv.mkDerivation
    {
      name = "drawernator";
      src = ./.;
      inherit nativeBuildInputs;
      buildInputs = [];
      #buildInputs = astalPackages;
    };

    devShells.${system}.default = pkgs.mkShell
    {
      #packages = nativeBuildInputs ++ astalPackages;
      #packages = nativeBuildInputs;
      nativeBuildInputs = nativeBuildInputs;
      buildInputs = buildInputs;

      shellHook =
      ''
        echo "GTK4 + Vala Dev Environment Loaded!"

        # This ensures icons and schemas are found on macOS
        export XDG_DATA_DIRS=$GSETTINGS_SCHEMAS_PATH:$XDG_DATA_DIRS
      '';
    };
  };
}
