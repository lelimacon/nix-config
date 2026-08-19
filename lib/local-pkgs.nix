# Local packages, shared by the common flake's own `packages` output
# (flake.nix) and by each host's system/home configuration (lib/default.nix).
{
  wrappers,
}:
{
  pkgs-ext = { pkgs }:
    import ../ext/index.nix { inherit pkgs; };

  pkgs-wrappers = { pkgs, pkgs-unstable, config }:
    import ../pkgs/index.nix { inherit pkgs pkgs-unstable wrappers config; };
}
