{
  inputs,
  outputs,
  nixpkgs,
  nixpkgs-unstable,
  nixpkgs-local,
  ...
}:
let
  get-pkgs = pkgs: system: import pkgs
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
  mkNixosSystemWithHome = {vars, config-path, home-config-path}:
    let
      pkgs = get-pkgs nixpkgs vars.system;
      pkgs-unstable = get-pkgs nixpkgs-unstable vars.system;
      pkgs-local = nixpkgs-local.${vars.system}; # reference to output packages.
      home-manager-in-system =
      {
        imports = [ inputs.home-manager.nixosModules.default ];
        home-manager =
        {
          users.${vars.user.name} = import home-config-path;
          #useGlobalPkgs = true;
          #useUserPackages = true;
          extraSpecialArgs = { inherit inputs outputs vars pkgs pkgs-unstable pkgs-local; };
        };
      };
    in
    nixpkgs.lib.nixosSystem
    {
      modules =
      [
        config-path
        home-manager-in-system
      ];
      specialArgs = { inherit inputs outputs vars pkgs pkgs-unstable pkgs-local; };
    };

  # Darwin system configuration.
  mkDarwinSystemWithHome = {vars, config-path, system-config-path, home-config-path}:
    let
      pkgs = get-pkgs nixpkgs vars.system;
      pkgs-unstable = get-pkgs nixpkgs-unstable vars.system;
      pkgs-local = nixpkgs-local.${vars.system}; # reference to output packages.
      home-manager-in-system =
      {
        imports = [ inputs.home-manager.darwinModules.home-manager ];
        home-manager =
        {
          users.${vars.user.name} = import home-config-path;
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = { inherit inputs outputs vars pkgs pkgs-unstable pkgs-local; };
          sharedModules = [ config-path ];
        };
      };
    in
    inputs.nix-darwin.lib.darwinSystem
    {
      modules =
      [
        config-path
        system-config-path
        home-manager-in-system
      ];
      specialArgs = { inherit inputs outputs vars pkgs pkgs-unstable pkgs-local; };
    };

  # Standalone Home Manager configuration.
  mkhomeConfiguration = {vars, home-config-path}:
    let
      pkgs = get-pkgs nixpkgs vars.system;
      pkgs-unstable = get-pkgs nixpkgs-unstable vars.system;
      pkgs-local = nixpkgs-local.${vars.system};
    in
    inputs.home-manager.lib.homeManagerConfiguration
    {
      pkgs = pkgs;
      modules = [ home-config-path ];
      extraSpecialArgs = { inherit inputs outputs vars pkgs pkgs-unstable pkgs-local; };
    };
}
