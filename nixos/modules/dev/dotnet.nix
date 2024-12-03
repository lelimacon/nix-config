{
  pkgs,
  ...
}:
let
  dotnet-sdks = with pkgs; dotnetCorePackages.combinePackages
  [
    dotnetCorePackages.sdk_6_0
    dotnetCorePackages.sdk_8_0
  ];
in
{
  environment.systemPackages = with pkgs;
  [
    dotnet-sdks
    powershell
    mono # for wine.
  ];

  environment.sessionVariables =
  {
    DOTNET_ROOT = "${dotnet-sdks}";
  };
}
