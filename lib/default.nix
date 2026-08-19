{
  inputs,
  outputs,
  nixpkgs,
  nixpkgs-unstable,
  ...
}:
let
  get-pkgs = import ./get-pkgs.nix;

  # Rebuilt per host (rather than reusing the common flake's output)
  # so `pkgs-wrappers` can use that host's `host-config`.
  local-pkgs = import ./local-pkgs.nix { inherit (inputs) wrappers; };
in
{
  # NixOS system configuration.
  mkNixosSystemWithHome = {host-config, system-config-path, home-config-path, extra-modules ? []}:
    let
      system = host-config.host.system;
      username = host-config.user.name;
      pkgs = get-pkgs nixpkgs system;
      pkgs-unstable = get-pkgs nixpkgs-unstable system;
      pkgs-ext = local-pkgs.pkgs-ext { inherit pkgs; };
      pkgs-wrappers = local-pkgs.pkgs-wrappers { inherit pkgs pkgs-unstable; config = host-config; };
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
          extraSpecialArgs = { inherit inputs outputs pkgs pkgs-unstable pkgs-ext pkgs-wrappers; };
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
      specialArgs = { inherit inputs outputs pkgs pkgs-unstable pkgs-ext pkgs-wrappers; };
    };

  # Darwin system configuration.
  mkDarwinSystemWithHome = {host-config, system-config-path, home-config-path, extra-modules ? []}:
    let
      system = host-config.host.system;
      username = host-config.user.name;
      pkgs = get-pkgs nixpkgs system;
      pkgs-unstable = get-pkgs nixpkgs-unstable system;
      pkgs-ext = local-pkgs.pkgs-ext { inherit pkgs; };
      pkgs-wrappers = local-pkgs.pkgs-wrappers { inherit pkgs pkgs-unstable; config = host-config; };
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
          extraSpecialArgs = { inherit inputs outputs pkgs pkgs-unstable pkgs-ext pkgs-wrappers; };
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
      specialArgs = { inherit inputs outputs pkgs pkgs-unstable pkgs-ext pkgs-wrappers; };
    };

  # Standalone Home Manager configuration.
  mkHomeConfiguration = {host-config, home-config-path, extra-modules ? []}:
    let
      system = host-config.host.system;
      pkgs = get-pkgs nixpkgs system;
      pkgs-unstable = get-pkgs nixpkgs-unstable system;
      pkgs-ext = local-pkgs.pkgs-ext { inherit pkgs; };
      pkgs-wrappers = local-pkgs.pkgs-wrappers { inherit pkgs pkgs-unstable; config = host-config; };
    in
    inputs.home-manager.lib.homeManagerConfiguration
    {
      pkgs = pkgs;
      modules = [ host-config home-config-path ] ++ extra-modules;
      extraSpecialArgs = { inherit inputs outputs pkgs pkgs-unstable pkgs-ext pkgs-wrappers; };
    };
}
