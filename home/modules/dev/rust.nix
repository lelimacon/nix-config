{
  pkgs,
  pkgs-unstable,
  ...
}:
{
  home.packages = with pkgs;
  [
    # https://github.com/nixos/nixpkgs/issues/426815
    (pkgs-unstable.jetbrains.rust-rover.override {
      jdk = pkgs.openjdk21;
    }) # Rust IDE.
  ];
}
/*
let
  dotnet-sdks = with pkgs; dotnetCorePackages.combinePackages
  [
    dotnetCorePackages.sdk_8_0
    dotnetCorePackages.sdk_9_0
  ];

  rust-rover-extra-path = with pkgs;
  [
    dotnet-sdks
    powershell
  ];

  rust-rover-extra-lib = with pkgs;
  [
  ];

  # JetBrains dotnet IDE.
  rust-rover = (pkgs-unstable.jetbrains.rust-rover.override
  {
    # https://github.com/nixos/nixpkgs/issues/426815
    jdk = pkgs.openjdk21;
  }).overrideAttrs (attrs:
  {
    # Wrap executable with additional arguments.
    postInstall =
    ''
    # Wrap with extra tools and libraries.
    mv $out/bin/rust-rover $out/bin/.rust-rover-toolless
    makeWrapper $out/bin/.rust-rover-toolless $out/bin/rust-rover \
      --argv0 rust-rover \
      --prefix PATH : "${pkgs.lib.makeBinPath rust-rover-extra-path}" \
      --prefix LD_LIBRARY_PATH : "${pkgs.lib.makeLibraryPath rust-rover-extra-lib}"

    # Making Unity Rider plugin work.
    # The plugin expects the binary to be at /rider/bin/rider,
    # with bundled files at /rider/.
    # Rider binary is at $out/bin/rider, so we link $out/rider/ to $out/.
    #shopt -s extglob
    #ln -s $out/rider/!(bin) $out/
    #shopt -u extglob
    '' +
    attrs.postInstall or "";
  });

  desktopFile = pkgs.makeDesktopItem
  {
    name = "jetbrains-rust-rover";
    desktopName = "Rider";
    exec = "\"${rust-rover}/bin/rust-rover\"";
    icon = "rust-rover";
    type = "Application";
    extraConfig.NoDisplay = "true"; # hide (duplicate) desktop icon.
  };
in
{
  home.packages =
  [
    rust-rover
  ];

  home.file.".local/share/applications/jetbrains-rust-rover.desktop".source =
    "${desktopFile}/share/applications/jetbrains-rust-rover.desktop";
}
*/
