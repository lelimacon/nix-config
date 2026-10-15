{
  lib,
  pkgs,
  ...
}:
let
  inherit (import ../../lib/wrapping.nix { inherit pkgs; }) pkgAlias;
in
{
  environment.systemPackages = with pkgs;
  lib.optionals (!pkgs.stdenv.isDarwin)
  [
    ungoogled-chromium # Chrome without the spyware.
  ] ++ lib.optionals pkgs.stdenv.isDarwin
  [
    # Installed via Homebrew, with an alias to the app binary.
    (pkgAlias "chromium" "/Applications/Chromium.app/Contents/MacOS/Chromium")
  ];
} // lib.optionalAttrs pkgs.stdenv.isDarwin
{
  homebrew.casks =
  [
    "ungoogled-chromium" # Chrome without the spyware.
  ];
}
