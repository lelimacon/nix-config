{
  pkgs,
  pkgs-unstable,
  ...
}:
{
  environment.systemPackages = with pkgs;
  [
    # https://github.com/nixos/nixpkgs/issues/426815
    (pkgs-unstable.jetbrains.rust-rover.override {
      jdk = pkgs.openjdk21;
    }) # Rust IDE.
    #rust-rover
  ];
}
/*
let
  rust-rover-extra-path = with pkgs;
  [
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

    # Making Unity RustRover plugin work.
    # The plugin expects the binary to be at /rust-rover/bin/rust-rover,
    # with bundled files at /rust-rover/.
    # RustRover binary is at $out/bin/rust-rover, so we link $out/rust-rover/ to $out/.
    #shopt -s extglob
    #ln -s $out/rust-rover/!(bin) $out/
    #shopt -u extglob
    '' +
    attrs.postInstall or "";
  });

  desktopFile = pkgs.makeDesktopItem
  {
    name = "jetbrains-rust-rover";
    desktopName = "RustRover";
    exec = "\"${rust-rover}/bin/rust-rover\"";
    icon = "rust-rover";
    type = "Application";
    extraConfig.NoDisplay = "true"; # hide (duplicate) desktop icon.
  };
in
{
  environment.systemPackages = with pkgs;
  [
    #rust-rover
  ];

  environment.etc."xdg/applications/jetbrains-rust-rover.desktop".source =
    "${desktopFile}/share/applications/jetbrains-rust-rover.desktop";
}
*/
