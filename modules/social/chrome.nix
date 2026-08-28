{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs;
  [
    ungoogled-chromium # Chrome without the spyware.
  ];
}
