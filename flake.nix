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
    pkgs = nixpkgs.legacyPackages.${system};
    pkgs-stable = inputs.nixpkgs-stable.legacyPackages.${system};
  in
  {
    nixosConfigurations."surfaceLaptop3" = nixpkgs.lib.nixosSystem
    {
      system = "x86_64-linux";
      modules =
      [
        ./nixos
        ./hosts/surfaceLaptop3
      ];
      specialArgs =
      {
        inherit inputs outputs pkgs-stable;
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

    #packages.${system}.hello = pkgs.hello;
    #packages.${system}.default = pkgs.hello;
    packages.${system} = {
      default = pkgs.hello;
      hello = pkgs.hello;
    };
    #packages.${system}.default = pkgs.hello;

    devShells.${system}.default = pkgs.mkShell {
      buildInputs = [ pkgs.neovim ];
    };
  };
}
