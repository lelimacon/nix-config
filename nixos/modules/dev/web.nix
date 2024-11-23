{
  pkgs,
  pkgs-stable,
  ...
}:
{
  environment.systemPackages = with pkgs;
  [
    nodejs_22
    bun
    dart-sass # scss.
  ];
}
