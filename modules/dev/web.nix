{
  pkgs,
  pkgs-wrappers,
  ...
}:
{
  environment.systemPackages = with pkgs;
  [
    nodejs_22
    bun
    dart-sass # scss.
    caddy # HTTP web server.

    # API testing.
    postman
    #pkgs-unstable.httpie-desktop
    bruno

    # IDE.
    pkgs-wrappers.jetbrains-webstorm
  ];
}
