{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs;
  [
    podman-compose
    lazydocker # terminal UI for Docker.
  ];

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
