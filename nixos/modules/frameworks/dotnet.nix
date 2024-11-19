{
  pkgs,
  pkgs-stable,
  ...
}:
{
  environment.systemPackages = with pkgs;
  [
    dotnet-sdk # 6.
    dotnet-sdk_8

    mono # for wine.
  ];

  environment.sessionVariables =
  {
    DOTNET_ROOT = "${pkgs.dotnet-sdk}";
  };
}
