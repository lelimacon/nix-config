{
  pkgs,
  pkgs-unstable,
  ...
}:
{
  home.packages = with pkgs;
  [
    nodejs_22
    bun
    dart-sass # scss.

    # API testing.
    postman
    pkgs-unstable.httpie-desktop
    bruno
  ];
}
