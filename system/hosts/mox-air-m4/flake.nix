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

  outputs =
  {
    common,
    self,
    ...
  }:
  let
    config-module = import ./configuration.nix { inherit self; };
    system-config-path = ./system-configuration.nix;
    home-config-path = ../../../home/profiles/mox-air-m4.nix;
  in
  {
    # System configuration with Home Manager.
    darwinConfigurations."${config-module.host.name}" =
      common.my-lib.mkDarwinSystemWithHome
      {
        inherit config-module system-config-path home-config-path;
      };

    # Standalone Home Manager configuration.
    # `home-manager switch`.
    # Home Manager is also tied to system configuration.
    homeConfigurations."${config-module.host.name}-${config-module.user.name}" =
      common.my-lib.mkHomeConfiguration
      {
        inherit config-module home-config-path;
      };
  };
}
