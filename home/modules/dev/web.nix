{
  pkgs,
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
    #httpie-desktop
  ];
}
