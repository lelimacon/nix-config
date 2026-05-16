{
  description = "Host-specific flake";

  inputs =
  {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-25.11-darwin";
    #nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    common =
    {
      url  = "./../../../";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixpkgs-unstable.follows = "nixpkgs-unstable";
    };
  };

  outputs = inputs @
  {
    common,
    self,
    ...
  }:
  let
    inherit (self) outputs;

    config-path = ./configuration.nix;
    home-config-path = ../../../home/profiles/max-air-m4.nix;
    vars =
    {
      system = "aarch64-darwin";
      config.path = ./.;
      config.rev = self.rev or self.dirtyRev or null;
      user.name = "max";
      user.homeDirectory = "/Users/max";
      hostName = "max-air-m4";
    };
  in
  {
    # System configuration.
    darwinConfigurations."${vars.hostName}" =
      common.lib.mkDarwinSystemWithHome { inherit vars config-path home-config-path; };

    # Standalone Home Manager configuration.
    # `home-manager switch`.
    # Home Manager is also tied to system configuration.
    homeConfigurations."${vars.hostName}-${vars.user.name}" =
      common.lib.mkHomeConfiguration { inherit vars home-config-path; };
  };
}
