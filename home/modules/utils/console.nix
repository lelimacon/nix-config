{
  pkgs-wrappers,
  ...
}:
{
  home.packages =
  [
    pkgs-wrappers.bash
    pkgs-wrappers.kitty
  ];
}
