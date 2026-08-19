{
  inputs,
  outputs,
  nixpkgs,
  nixpkgs-unstable,
  nixpkgs-local,
  ...
}:
let
  get-pkgs = import ./get-pkgs.nix;
in
{
  get-pkgs = get-pkgs;

  # NixOS system configuration.
  mkNixosSystemWithHome = {host-config, system-config-path, home-config-path, extra-modules ? []}:
    let
      system = host-config.host.system;
      username = host-config.user.name;
      pkgs = get-pkgs nixpkgs system;
      pkgs-unstable = get-pkgs nixpkgs-unstable system;
      pkgs-local = nixpkgs-local.${system}; # reference to output packages.
      # Still forced via specialArgs too (home-manager needs it at import time).
      # `nixpkgs.pkgs` marks it external, so NixOS skips building an unused copy.
      pkgs-module = { nixpkgs.pkgs = pkgs; };
      home-manager-in-system =
      {
        imports = [ inputs.home-manager.nixosModules.default ];
        home-manager =
        {
          users.${username} = import home-config-path;
          #useGlobalPkgs = true;
          #useUserPackages = true;
          extraSpecialArgs = { inherit inputs outputs pkgs pkgs-unstable pkgs-local; };
          sharedModules = [ host-config ];
        };
      };
    in
    nixpkgs.lib.nixosSystem
    {
      modules =
      [
        host-config
        pkgs-module
        system-config-path
        home-manager-in-system
      ] ++ extra-modules;
      specialArgs = { inherit inputs outputs pkgs pkgs-unstable pkgs-local; };
    };

  # Darwin system configuration.
  mkDarwinSystemWithHome = {host-config, system-config-path, home-config-path, extra-modules ? []}:
    let
      system = host-config.host.system;
      username = host-config.user.name;
      pkgs = get-pkgs nixpkgs system;
      pkgs-unstable = get-pkgs nixpkgs-unstable system;
      pkgs-local = nixpkgs-local.${system}; # reference to output packages.
      # See the comment in mkNixosSystemWithHome, same logic for nix-darwin.
      pkgs-module = { nixpkgs.pkgs = pkgs; };
      home-manager-in-system =
      {
        imports = [ inputs.home-manager.darwinModules.home-manager ];
        home-manager =
        {
          users.${username} = import home-config-path;
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = { inherit inputs outputs pkgs pkgs-unstable pkgs-local; };
          sharedModules = [ host-config ];
        };
      };
    in
    inputs.nix-darwin.lib.darwinSystem
    {
      modules =
      [
        host-config
        pkgs-module
        system-config-path
        home-manager-in-system
      ] ++ extra-modules;
      specialArgs = { inherit inputs outputs pkgs pkgs-unstable pkgs-local; };
    };

  # Standalone Home Manager configuration.
  mkHomeConfiguration = {host-config, home-config-path, extra-modules ? []}:
    let
      system = host-config.host.system;
      pkgs = get-pkgs nixpkgs system;
      pkgs-unstable = get-pkgs nixpkgs-unstable system;
      pkgs-local = nixpkgs-local.${system};
    in
    inputs.home-manager.lib.homeManagerConfiguration
    {
      pkgs = pkgs;
      modules = [ host-config home-config-path ] ++ extra-modules;
      extraSpecialArgs = { inherit inputs outputs pkgs pkgs-unstable pkgs-local; };
    };
}
