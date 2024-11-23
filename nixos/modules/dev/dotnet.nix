{
  pkgs,
  pkgs-stable,
  ...
}:
{
  environment.systemPackages = with pkgs;
  [
    (dotnetCorePackages.combinePackages [
      dotnetCorePackages.sdk_6_0
      dotnetCorePackages.sdk_8_0
    ])

    powershell
    mono # for wine.
  ];

  environment.sessionVariables =
  {
    DOTNET_ROOT = "${pkgs.dotnet-sdk}";
  };
}
