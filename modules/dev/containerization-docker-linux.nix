{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs;
  [
    lazydocker # terminal UI for Docker.
  ];

  # Also installs the `docker` CLI.
  virtualisation.docker.enable = true;
  virtualisation.docker.daemon.settings =
  {
    userland-proxy = false;
    #experimental = true;
    #metrics-addr = "0.0.0.0:9323";
    #ipv6 = true;
    #fixed-cidr-v6 = "fd00::/80";
  };
}
