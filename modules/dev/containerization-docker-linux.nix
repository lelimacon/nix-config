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
    # Keep the userland proxy enabled. With it disabled, loopback access to
    # published ports only works on the default `docker0` bridge (Docker adds
    # `-A POSTROUTING -o docker0 -m addrtype --src-type LOCAL -j MASQUERADE`
    # for it, and no equivalent for user-defined bridges). Compose creates a
    # user-defined bridge, so `http://127.0.0.1:<port>/` would answer with
    # ICMP host-unreachable while the LAN IP still works.
    userland-proxy = true;
    #experimental = true;
    #metrics-addr = "0.0.0.0:9323";
    #ipv6 = true;
    #fixed-cidr-v6 = "fd00::/80";
  };
}
