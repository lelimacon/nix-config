{
  description = "Configuration of lelimacon";

  inputs =
  {
    ags.url = "github:Aylur/ags/v1";

    drawernator =
    {
      # https://github.com/NixOS/nix/issues/9339
      url = "path:ext/Drawernator";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager =
    {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

    nix-flatpak.url = "github:gmodena/nix-flatpak/main";

    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
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
      specialArgs = { inherit inputs outputs pkgs-unstable system; };
    };

    # Standalone Home Manager configuration.
    # `home-manager switch`.
    homeConfigurations.${userName} = home-manager.lib.homeManagerConfiguration
    {
      pkgs = pkgs;
      modules = [ ./home/profiles/all.nix ];
      extraSpecialArgs = { inherit inputs system; };
    };
  };
}
