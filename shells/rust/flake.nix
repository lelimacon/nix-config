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
      pkgs = import nixpkgs
      {
        system = system;
      };
    in
    {
      # To run VS Code :
      # $ nix develop --command codium
      devShells.default = pkgs.mkShell
      {
        buildInputs = with pkgs;
        [
          cargo
          rustc
        ];
      };
    }
  );
}
