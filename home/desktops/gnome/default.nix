{
  config,
  pkgs,
  ...
}:
{
  imports =
  [
    ./dconf.nix
    ./extensions.nix
  ];
}
