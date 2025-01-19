{
  description = "Rust shell";

  inputs =
  {
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
    flake-utils,
    nixpkgs,
    self,
    ...
  }:
  flake-utils.lib.eachDefaultSystem (system:
    let
      overrides = (builtins.fromTOML (builtins.readFile (self + "/rust-toolchain.toml")));
      pkgs = import nixpkgs
      {
        inherit system;
      };
      libPath = with pkgs; lib.makeLibraryPath
      [
        # load external libraries that you need in your rust project here
      ];
    in
    {
      # To run VS Code :
      # $ nix develop --command codium
      devShells.default = pkgs.mkShell rec
      {
        nativeBuildInputs = [ pkgs.pkg-config ];
        buildInputs = with pkgs;
        [
          clang
          llvmPackages.bintools
          rustup
        ];

        RUSTC_VERSION = overrides.toolchain.channel;

        # https://github.com/rust-lang/rust-bindgen#environment-variables
        LIBCLANG_PATH = pkgs.lib.makeLibraryPath [ pkgs.llvmPackages_latest.libclang.lib ];

        shellHook =
        ''
          export CARGO_HOME=''${CARGO_HOME:-~/.cargo}/bin/
          export RUSTUP_HOME=''${RUSTUP_HOME:-~/.rustup}/toolchains/$RUSTC_VERSION-x86_64-unknown-linux-gnu/bin/
          export PATH=$PATH:$CARGO_HOME
          export PATH=$PATH:$RUSTUP_HOME

          echo "RUSTUP_HOME: $RUSTUP_HOME"
          echo "CARGO_HOME: $CARGO_HOME"
          echo "Rust version: $(rustc --version)"
          echo "Cargo version: $(cargo --version)"
        '';

        # Add precompiled library to rustc search path
        RUSTFLAGS = (builtins.map (a: ''-L ${a}/lib'')
        [
          # add libraries here (e.g. pkgs.libvmi)
        ]);

        LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath (buildInputs ++ nativeBuildInputs);

        # Add glibc, clang, glib, and other headers to bindgen search path
        BINDGEN_EXTRA_CLANG_ARGS =
          # Includes normal include path
          (builtins.map (a: ''-I"${a}/include"'') [
            # add dev libraries here (e.g. pkgs.libvmi.dev)
            pkgs.glibc.dev
          ])
          # Includes with special directory paths
          ++ [
            ''-I"${pkgs.llvmPackages_latest.libclang.lib}/lib/clang/${pkgs.llvmPackages_latest.libclang.version}/include"''
            ''-I"${pkgs.glib.dev}/include/glib-2.0"''
            ''-I${pkgs.glib.out}/lib/glib-2.0/include/''
          ];
      };
    }
  );
}
