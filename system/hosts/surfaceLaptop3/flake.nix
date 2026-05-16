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

  outputs = inputs @
  {
    common,
    self,
    ...
  }:
  let
    inherit (self) outputs;

    config-path = ./configuration.nix;
    home-config-path = ../../../home/profiles/surface-laptop-3.nix;
    vars =
    {
      system = "x86_64-linux";
      config.path = ./.;
      config.rev = self.rev or self.dirtyRev or null;
      user.name = "lelimacon";
      user.homeDirectory = "/home/lelimacon";
      hostName = "surfaceLaptop3";
    };

    # pkgs = import nixpkgs
    # {
    #   system = vars.system;
    #   config =
    #   {
    #     allowUnfree = true;
    #     allowUnfreePredicate = _: true;
    #   };
    # };
    # pkgs-unstable = import inputs.nixpkgs-unstable
    # {
    #   system = vars.system;
    #   config =
    #   {
    #     allowUnfree = true;
    #     allowUnfreePredicate = _: true;
    #   };
    # };
  in
  {
    # System configuration.
    nixosConfigurations."${vars.hostName}" =
      common.lib.mkNixosSystemWithHome { inherit vars config-path home-config-path; };

    # Standalone Home Manager configuration.
    # `home-manager switch`.
    # Home Manager is also tied to system configuration.
    homeConfigurations."${vars.user.name}" =
      common.lib.mkHomeConfiguration { inherit vars home-config-path; };

    # # System configuration.
    # # `nixos-rebuild switch`.
    # nixosConfigurations."${vars.hostName}" = nixpkgs.lib.nixosSystem
    # {
    #   pkgs = pkgs;
    #   modules = [ ./system/hosts/surfaceLaptop3 ];
    #   specialArgs = { inherit inputs outputs vars pkgs pkgs-unstable; };
    # };

    # # Standalone Home Manager configuration.
    # # `home-manager switch`.
    # # Also tied to system configuration in /hosts/*/default.nix
    # homeConfigurations."${vars.user.name}" = home-manager.lib.homeManagerConfiguration
    # {
    #   pkgs = pkgs;
    #   modules = [ ./home/profiles/all.nix ];
    #   extraSpecialArgs = { inherit inputs outputs vars pkgs pkgs-unstable; };
    # };
  };
}
