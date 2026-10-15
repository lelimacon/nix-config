{
  lib,
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
  ] ++ lib.optionals pkgs.stdenv.isDarwin
  [
    # Podman with an alias from `docker`.
    podman
    (pkgAlias "docker" "${pkgs.podman}/bin/podman")
  ];
} // lib.optionalAttrs pkgs.stdenv.isLinux
{
  # Installs podman and enables the user-level `podman.socket`
  # (`/run/user/<uid>/podman/podman.sock`).
  virtualisation.podman =
  {
    enable = true;
    dockerCompat = true; # `docker` alias.
  };

  # Point Docker clients (e.g. lazydocker) to the rootless Podman socket.
  environment.extraInit = ''
    export DOCKER_HOST="unix://$XDG_RUNTIME_DIR/podman/podman.sock"
  '';
}
