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

  # Evaluate config to apply the default options.
  eval-host-config = host-config: (nixpkgs.lib.evalModules { modules = [ host-config ]; }).config;
in
{
  # NixOS system configuration.
  mkNixosSystem = {host-config, system-config-path, extra-modules ? []}:
    let
      system = host-config.host.system;
      pkgs = get-pkgs nixpkgs system;
      pkgs-unstable = get-pkgs nixpkgs-unstable system;
      pkgs-ext = local-pkgs.pkgs-ext { inherit pkgs; };
      host-config-eval = eval-host-config host-config;
      pkgs-wrappers = local-pkgs.pkgs-wrappers { inherit pkgs pkgs-unstable; config = host-config-eval; };
      # `nixpkgs.pkgs` marks it external, so NixOS skips building an unused copy.
      # It also makes `pkgs` available as a module argument, so it must NOT be
      # added to `specialArgs` (that triggers an evaluation warning in
      # nixos/lib/eval-config.nix).
      pkgs-module = { nixpkgs.pkgs = pkgs; };
    in
    nixpkgs.lib.nixosSystem
    {
      modules =
      [
        host-config
        pkgs-module
        system-config-path
      ] ++ extra-modules;
      # `host` has to come through `specialArgs`: modules branch on
      # `host.isDarwin`/`host.isLinux` at their *top level* (e.g. to define
      # Darwin-only options such as `launchd`), and `config` can not be read
      # there without an infinite recursion.
      specialArgs = { inherit inputs outputs pkgs-unstable pkgs-ext pkgs-wrappers; host = host-config-eval.host; };
    };

  # Darwin system configuration.
  mkDarwinSystem = {host-config, system-config-path, extra-modules ? []}:
    let
      system = host-config.host.system;
      pkgs = get-pkgs nixpkgs system;
      pkgs-unstable = get-pkgs nixpkgs-unstable system;
      pkgs-ext = local-pkgs.pkgs-ext { inherit pkgs; };
      host-config-eval = eval-host-config host-config;
      pkgs-wrappers = local-pkgs.pkgs-wrappers { inherit pkgs pkgs-unstable; config = host-config-eval; };
      # See the comment in mkNixosSystem, same logic for nix-darwin.
      pkgs-module = { nixpkgs.pkgs = pkgs; };
    in
    inputs.nix-darwin.lib.darwinSystem
    {
      modules =
      [
        host-config
        pkgs-module
        system-config-path
      ] ++ extra-modules;
      specialArgs = { inherit inputs outputs pkgs-unstable pkgs-ext pkgs-wrappers; host = host-config-eval.host; };
    };
}
