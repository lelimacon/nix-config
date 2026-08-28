{
  pkgs-wrappers,
  ...
}:
{
  environment.systemPackages =
  [
    pkgs-wrappers.firefox
  ];
}
