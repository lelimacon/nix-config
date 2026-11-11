# Chrome on macOS, installed via Homebrew.
{
  pkgs,
  ...
}:
let
  inherit (import ../../lib/wrapping.nix { inherit pkgs; }) pkgAlias;

  # Tools (e.g. Flutter) look for a binary literally named `chromium`.
  chromium = pkgAlias "chromium" "/Applications/Chromium.app/Contents/MacOS/Chromium";
in
{
  environment.systemPackages =
  [
    chromium
  ];

  environment.variables.CHROME_EXECUTABLE = "${chromium}/bin/chromium";

  homebrew.casks =
  [
    "ungoogled-chromium" # Chrome without the spyware.
  ];
}
