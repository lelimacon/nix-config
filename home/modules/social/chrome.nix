{
  pkgs,
  ...
}:
{
  home.packages = with pkgs;
  [
    ungoogled-chromium # Chrome without the spyware.
  ];
}
