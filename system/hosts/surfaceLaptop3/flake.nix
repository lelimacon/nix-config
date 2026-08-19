{
  description = "Host-specific flake";

  inputs =
  {
    # home-manager =
    # {
    #   url = "github:nix-community/home-manager/release-25.11";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    #hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

    # TODO: Add?
    #nix-flatpak.url = "github:gmodena/nix-flatpak/main";

    #nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    #systems.url = "github:nix-systems/x86_64-linux";

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
    home-config-path = ../../../home/profiles/surface-laptop-3.nix;
  in
  {
    # System configuration with Home Manager.
    nixosConfigurations."${host-config.host.name}" =
      common.my-lib.mkNixosSystemWithHome
      {
        inherit host-config system-config-path home-config-path;
        extra-modules = [ flake-config ];
      };

    # Standalone Home Manager configuration.
    # `home-manager switch`.
    # Home Manager is also tied to system configuration.
    homeConfigurations."${host-config.user.name}" =
      common.my-lib.mkHomeConfiguration
      {
        inherit host-config home-config-path;
        extra-modules = [ flake-config ];
      };
  };
}
