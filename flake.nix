{
  description = "Configuration of lelimacon";

  inputs =
  {
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager =
    {
      #url = "github:nix-community/home-manager/release-24.05";
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    ags.url = "github:Aylur/ags/v1";
    #astal =
    #{
    #  url = "github:aylur/astal";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};
  };

  outputs = inputs @
  {
    self,
    nixpkgs,
    home-manager,
    ...
  }:
  let
    inherit (self) outputs;

    userName = "lelimacon";
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    pkgs-stable = inputs.nixpkgs-stable.legacyPackages.${system};
  in
  {
    # System configuration.
    # `nixos-rebuild switch`.
    nixosConfigurations."surfaceLaptop3" = nixpkgs.lib.nixosSystem
    {
      #system = "x86_64-linux";
      modules = [ ./nixos/hosts/surfaceLaptop3 ];
      specialArgs = { inherit inputs outputs pkgs-stable; };
    };

    # Standalone Home Manager configuration.
    # `home-manager switch`.
    homeConfigurations.${userName} = home-manager.lib.homeManagerConfiguration
    {
      pkgs = nixpkgs.legacyPackages.${system};
      modules = [ ./home/profiles/all.nix ];
      extraSpecialArgs = { inherit inputs; };
    };
  };
}
