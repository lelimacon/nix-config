{
  pkgs,
  ...
}:
let
  inherit (import ../../lib/wrapping.nix { inherit pkgs; }) pkgAlias;
in
{
  environment.systemPackages = with pkgs;
  [
    podman-compose
    lazydocker # terminal UI for Docker.
    podman
    # Podman with an alias from `docker`.
    (pkgAlias "docker" "${pkgs.podman}/bin/podman")
  ];
}
