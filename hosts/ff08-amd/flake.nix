{
  description = "Host-specific flake";

  inputs =
  {
    # TODO: Add?
    #nix-flatpak.url = "github:gmodena/nix-flatpak/main";

    #nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    #systems.url = "github:nix-systems/x86_64-linux";

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
    nixosConfigurations."${host-config.host.name}" =
      common.my-lib.mkNixosSystem
      {
        inherit host-config system-config-path;
        extra-modules = [ flake-config ];
      };
  };
}
