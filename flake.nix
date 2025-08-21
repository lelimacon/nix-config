{
  description = "Configuration of lelimacon";

  inputs =
  {
    flake-utils =
    {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };

    home-manager =
    {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

    nix-flatpak.url = "github:gmodena/nix-flatpak/main";

    #nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    systems.url = "github:nix-systems/x86_64-linux";
  };

  outputs = inputs @
  {
    flake-utils,
    home-manager,
    nixpkgs,
    self,
    ...
  }:
  let
    inherit (self) outputs;

    userName = "lelimacon";
    system = "x86_64-linux";

    pkgs = import nixpkgs
    {
      system = system;
      config =
      {
        allowUnfree = true;
        allowUnfreePredicate = _: true;
      };
    };
    pkgs-unstable = import inputs.nixpkgs-unstable
    {
      system = system;
      config =
      {
        allowUnfree = true;
        allowUnfreePredicate = _: true;
      };
    };
  in
  {
    # System configuration.
    # `nixos-rebuild switch`.
    nixosConfigurations."surfaceLaptop3" = nixpkgs.lib.nixosSystem
    {
      pkgs = pkgs;
      modules = [ ./nixos/hosts/surfaceLaptop3 ];
      specialArgs = { inherit inputs outputs system pkgs pkgs-unstable; };
    };

    # Standalone Home Manager configuration.
    # `home-manager switch`.
    # Also tied to system configuration in /hosts/*/default.nix
    homeConfigurations.${userName} = home-manager.lib.homeManagerConfiguration
    {
      pkgs = pkgs;
      modules = [ ./home/profiles/all.nix ];
      extraSpecialArgs = { inherit inputs outputs system pkgs pkgs-unstable; };
    };
  };
}
