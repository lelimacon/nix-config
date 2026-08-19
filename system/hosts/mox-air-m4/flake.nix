{
  description = "Host-specific flake";

  inputs =
  {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-26.05-darwin";
    #nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    common =
    {
      url  = "./../../../";
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
    home-config-path = ../../../home/profiles/mox-air-m4.nix;
  in
  {
    # System configuration with Home Manager.
    darwinConfigurations."${host-config.host.name}" =
      common.my-lib.mkDarwinSystemWithHome
      {
        inherit host-config system-config-path home-config-path;
        extra-modules = [ flake-config ];
      };

    # Standalone Home Manager configuration.
    # `home-manager switch`.
    # Home Manager is also tied to system configuration.
    homeConfigurations."${host-config.host.name}-${host-config.user.name}" =
      common.my-lib.mkHomeConfiguration
      {
        inherit host-config home-config-path;
        extra-modules = [ flake-config ];
      };
  };
}
