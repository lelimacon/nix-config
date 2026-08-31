{
  config,
  pkgs,
  pkgs-unstable,
  wrappers,
  ...
}:
let
  dotnetSdks = pkgs.dotnetCorePackages.combinePackages
  [
    pkgs.dotnetCorePackages.sdk_8_0
    pkgs.dotnetCorePackages.sdk_9_0
  ];
in
import ./lib.nix
{
  inherit pkgs wrappers;

  package = pkgs-unstable.jetbrains.rider;

  env =
  {
    DOTNET_ROOT = "${dotnetSdks}/share/dotnet";
  };

  runtimePkgs =
  [
    dotnetSdks
    pkgs.powershell
  ];

  settings =
  {
    # JetBrains' font isn't ligature-aware, so it needs the "frozen" font variant.
    fonts =
    {
      fontFamily = config.theme.monoFont.frozenFamily;
      useLigatures = true;
    };

    themeId = "Islands Light";
    colorScheme = "Light";

    editor =
    {
      stripTrailingSpaces = "Whole";
      keepTrailingSpaceOnCaretLine = false;
    };
  };
}
