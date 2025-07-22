{
  pkgs,
  pkgs-unstable,
  ...
}:
{
  environment.systemPackages = with pkgs;
  [
    # Containerization.
    docker # GUI w/ yacht (compose service).
    lazydocker # terminal UI for Docker.

    # Editors.
    vscodium

    # Build tools.
    go-task # taskfile runner.
    deno # JS/TS runtime.
  ];
}
