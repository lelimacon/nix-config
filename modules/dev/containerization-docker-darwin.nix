{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs;
  [
    lazydocker # terminal UI for Docker.
    docker # CLI only, the daemon is provided by colima.
    colima # Linux VM running the Docker daemon.
  ];

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
}
