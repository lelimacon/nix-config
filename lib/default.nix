{
  inputs,
  outputs,
  nixpkgs,
  nixpkgs-unstable,
  nixpkgs-local,
  ...
}:
let
  get-pkgs = nixpkgs: system: import nixpkgs
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
  get-pkgs = get-pkgs;

  # NixOS system configuration.
  mkNixosSystemWithHome = {config-module, system-config-path, home-config-path}:
    let
      system = config-module.host.system;
      username = config-module.user.name;
      pkgs = get-pkgs nixpkgs system;
      pkgs-unstable = get-pkgs nixpkgs-unstable system;
      pkgs-local = nixpkgs-local.${system}; # reference to output packages.
      home-manager-in-system =
      {
        imports = [ inputs.home-manager.nixosModules.default ];
        home-manager =
        {
          users.${username} = import home-config-path;
          #useGlobalPkgs = true;
          #useUserPackages = true;
          extraSpecialArgs = { inherit inputs outputs pkgs pkgs-unstable pkgs-local; };
          sharedModules = [ config-module ];
        };
      };
    in
    nixpkgs.lib.nixosSystem
    {
      modules =
      [
        config-module
        system-config-path
        home-manager-in-system
      ];
      specialArgs = { inherit inputs outputs pkgs pkgs-unstable pkgs-local; };
    };

  # Darwin system configuration.
  mkDarwinSystemWithHome = {config-module, system-config-path, home-config-path}:
    let
      system = config-module.host.system;
      username = config-module.user.name;
      pkgs = get-pkgs nixpkgs system;
      pkgs-unstable = get-pkgs nixpkgs-unstable system;
      pkgs-local = nixpkgs-local.${system}; # reference to output packages.
      home-manager-in-system =
      {
        imports = [ inputs.home-manager.darwinModules.home-manager ];
        home-manager =
        {
          users.${username} = import home-config-path;
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = { inherit inputs outputs pkgs pkgs-unstable pkgs-local; };
          sharedModules = [ config-module ];
        };
      };
    in
    inputs.nix-darwin.lib.darwinSystem
    {
      modules =
      [
        config-module
        system-config-path
        home-manager-in-system
      ];
      specialArgs = { inherit inputs outputs pkgs pkgs-unstable pkgs-local; };
    };

  # Standalone Home Manager configuration (typesafe, config-based).
  mkHomeConfiguration = {config-module, home-config-path}:
    let
      system = config-module.host.system;
      pkgs = get-pkgs nixpkgs system;
      pkgs-unstable = get-pkgs nixpkgs-unstable system;
      pkgs-local = nixpkgs-local.${system};
    in
    inputs.home-manager.lib.homeManagerConfiguration
    {
      pkgs = pkgs;
      modules = [ config-module home-config-path ];
      extraSpecialArgs = { inherit inputs outputs pkgs pkgs-unstable pkgs-local; };
    };
}
