{
  description = "Configuration of lelimacon";

  inputs =
  {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";

    home-manager =
    {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    ags.url = "github:Aylur/ags";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    ...
  }:
  let
    inherit (self) outputs;

    userName = "lelimacon";
    system = "x86_64-linux";
  in
  {
    nixosConfigurations."surfaceLaptop3" = nixpkgs.lib.nixosSystem
    {
      modules =
      [
        ./nixos
        ./hosts/surfaceLaptop3
      ];
      specialArgs =
      {
        inherit inputs outputs;
      };
    };

    homeConfigurations."lelimacon" = home-manager.lib.homeManagerConfiguration
    {
      pkgs = nixpkgs.legacyPackages.${system};
      modules = [ ./home ];
      extraSpecialArgs =
      {
        inherit inputs outputs;
      };
    };
  };
}
