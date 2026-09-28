{
  description = "Host-specific flake";

  inputs =
  {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-26.05-darwin";
    #nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    common =
    {
      url  = "./../../";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixpkgs-unstable.follows = "nixpkgs-unstable";
    };
  };

  outputs =
  {
    common,
    self,
    ...
  }:
  let
    host-config = import ./host-config.nix;
    flake-config =
    {
      flake-src.path = ./.;
      flake-src.rev = self.rev or self.dirtyRev or null;
    };
    system-config-path = ./system-configuration.nix;
  in
  {
    darwinConfigurations."${host-config.host.name}" =
      common.my-lib.mkDarwinSystem
      {
        inherit host-config system-config-path;
        extra-modules = [ flake-config ];
      };
  };
}
