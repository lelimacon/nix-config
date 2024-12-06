{
  description = "Unearth the mold";

  inputs =
  {
    flake-utils =
    {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };

    nix-alien.url = "github:thiagokokada/nix-alien";

    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

    systems.url = "github:nix-systems/x86_64-linux";
  };

  outputs =
  {
    flake-utils,
    nix-alien,
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

      carbonVersion = "0.0.0-0.nightly.2024.12.01";

      carbonPackage = pkgs.stdenv.mkDerivation
      {
        pname = "carbon-nightly";
        version = carbonVersion;

        src = pkgs.fetchurl
        {
          url = "https://github.com/carbon-language/carbon-lang/releases/download/v${carbonVersion}/carbon_toolchain-${carbonVersion}.tar.gz";
          sha256 = "sha256-je8gvwoV2tOUpNC/yxvc0IZ9ToJHPqEnUZrggPSOnOA=";
        };

        buildPhase =
        ''
        '';

        installPhase =
        ''
          mkdir -p $out/bin
          mv ./bin/carbon $out/bin/
          mv ./lib/ $out/
        '';
      };

      nativeBuildInputs = with pkgs;
      [
        libgcc # libraries.
        nix-alien.packages.${system}.nix-alien # to run unpatched binaries (here: carbon).

        # Create carbon alias to run with nix-alien.
        (pkgs.writeShellScriptBin "carbon"
        ''
          exec nix-alien ${carbonPackage}/bin/carbon $@
        '')
      ];
    in
    {
      packages.carbon-nightly = carbonPackage;

      #packages.default = pkgs.stdenv.mkDerivation
      #{
      #  name = "MoldDigger";
      #  src = ./.;
      #  nativeBuildInputs = nativeBuildInputs;
      #  buildInputs = buildInputs;
      #};

      devShells.default = pkgs.mkShell
      {
        shellHook =
        ''
          echo "Carbon toolchain v${carbonVersion}"
          #alias carbon="nix-alien ${carbonPackage}/bin/carbon"
        '';
        nativeBuildInputs = nativeBuildInputs;
      };
    }
  );
}
