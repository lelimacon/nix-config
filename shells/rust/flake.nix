{
  description = ".NET shell";

  inputs =
  {
    flake-utils =
    {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };

    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

    rust-overlay.url = "github:oxalica/rust-overlay";

    systems.url = "github:nix-systems/x86_64-linux";
  };

  outputs =
  {
    flake-utils,
    nixpkgs,
    rust-overlay,
    self,
    ...
  }:
  flake-utils.lib.eachDefaultSystem (system:
    let
      overlays = [ (import rust-overlay) ];
      pkgs = import nixpkgs
      {
        inherit system overlays;
      };
    in
    {
      # To run VS Code :
      # $ nix develop --command codium
      devShells.default = pkgs.mkShell
      {
        buildInputs = with pkgs;
        [
          openssl
          pkg-config
          eza
          fd
          rust-bin.stable.latest.default
        ];
      };
    }
  );
}
