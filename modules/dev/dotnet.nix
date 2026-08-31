{
  pkgs-wrappers,
  ...
}:
{
  environment.systemPackages =
  [
    # IDE.
    pkgs-wrappers.jetbrains-rider
  ];
}
