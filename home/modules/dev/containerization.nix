{
  pkgs,
  ...
}:
{
  home.packages = with pkgs;
  [
    docker
    lazydocker # terminal UI for Docker.
  ];
}
