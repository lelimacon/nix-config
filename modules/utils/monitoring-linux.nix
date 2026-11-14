{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs;
  [
    psmisc # `killall`, `pstree`, `fuser`.
    procps # `ps`.
    bottom # process monitor TUI.
    iotop # TUI to find processes doing the most IO.
    net-tools # `ifconfig`, `netstat`.
  ];
}
