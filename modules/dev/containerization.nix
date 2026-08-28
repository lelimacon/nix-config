{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs;
  [
    docker
    lazydocker # terminal UI for Docker.
  ];
}
