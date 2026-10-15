{
  lib,
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs;
  [
    lazydocker # terminal UI for Docker.
  ] ++ lib.optionals pkgs.stdenv.isDarwin
  [
    docker # CLI only, the daemon is provided by colima.
    colima # Linux VM running the Docker daemon.
  ];
} // lib.optionalAttrs pkgs.stdenv.isDarwin
{
  # Start colima at login and switch the Docker context to `colima`.
  launchd.user.agents.colima =
  {
    command = "${pkgs.colima}/bin/colima start --foreground";
    path = [ pkgs.colima pkgs.docker "/usr/bin" "/bin" "/usr/sbin" "/sbin" ];
    serviceConfig =
    {
      RunAtLoad = true;
      KeepAlive = true;
      StandardOutPath = "/tmp/colima.log";
      StandardErrorPath = "/tmp/colima.log";
    };
  };
} // lib.optionalAttrs pkgs.stdenv.isLinux
{
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
