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
    #ags.url = "github:Aylur/ags";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    ...
  }:
  let
    hostName = "nixos";
    userName = "lelimacon";
  in
  {
    nixosConfigurations.${hostName} = nixpkgs.lib.nixosSystem
    {
      specialArgs =
      {
        inherit inputs;
      };
      modules = [./nixos];
    };

    homeConfigurations.${userName} = home-manager.lib.homeManagerConfiguration
    {
      pkgs = nixpkgs.legacyPackages."x86_64-linux";
      extraSpecialArgs =
      {
        inherit inputs;
      };
      modules = [./home];
    };
  };
}
