{
  pkgs,
  ...
}:
let
  dotnet-sdks = with pkgs; dotnetCorePackages.combinePackages
  [
    dotnetCorePackages.sdk_8_0
    dotnetCorePackages.sdk_9_0
  ];
in
pkgs.mkShell
{
  description = ".NET shell";

  buildInputs = with pkgs;
  [
    dotnet-sdks
    #dotnet-ef # Entity Framework tools.
    powershell
  ];

  shellHook =
  ''
    export DOTNET_ROOT="${dotnet-sdks}/share/dotnet";
    export PATH="$PATH:/home/$USER/.dotnet/tools";
  '';
}
