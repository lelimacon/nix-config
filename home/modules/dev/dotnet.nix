{
  pkgs,
  pkgs-unstable,
  ...
}:
# https://huantian.dev/blog/unity3d-rider-nixos/
let
  dotnet-sdks = with pkgs; dotnetCorePackages.combinePackages
  [
    dotnetCorePackages.sdk_8_0
    dotnetCorePackages.sdk_9_0
  ];

  rider-extra-path = with pkgs;
  [
    dotnet-sdks
    powershell
  ];

  rider-extra-lib = with pkgs;
  [
  ];

  # JetBrains dotnet IDE.
  rider = (pkgs-unstable.jetbrains.rider.override
  {
    # https://github.com/nixos/nixpkgs/issues/426815
    jdk = pkgs.openjdk21;
  }).overrideAttrs (attrs:
  {
    # Wrap Rider exe with additional arguments.
    postInstall =
    ''
    # Wrap rider with extra tools and libraries.
    mv $out/bin/rider $out/bin/.rider-toolless
    makeWrapper $out/bin/.rider-toolless $out/bin/rider \
      --argv0 rider \
      --prefix PATH : "${pkgs.lib.makeBinPath rider-extra-path}" \
      --prefix LD_LIBRARY_PATH : "${pkgs.lib.makeLibraryPath rider-extra-lib}"

    # Making Unity Rider plugin work.
    # The plugin expects the binary to be at /rider/bin/rider,
    # with bundled files at /rider/.
    # Rider binary is at $out/bin/rider, so we link $out/rider/ to $out/.
    shopt -s extglob
    ln -s $out/rider/!(bin) $out/
    shopt -u extglob
    '' +
    attrs.postInstall or "";
  });

  desktopFile = pkgs.makeDesktopItem
  {
    name = "jetbrains-rider";
    desktopName = "Rider";
    exec = "\"${rider}/bin/rider\"";
    icon = "rider";
    type = "Application";
    extraConfig.NoDisplay = "true"; # hide (duplicate) desktop icon.
  };
in
{
  home.packages =
  [
    rider
  ];

  home.file.".local/share/applications/jetbrains-rider.desktop".source =
    "${desktopFile}/share/applications/jetbrains-rider.desktop";
}
