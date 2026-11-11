# Chrome on Linux.
{
  pkgs,
  ...
}:
let
  inherit (import ../../lib/wrapping.nix { inherit pkgs; }) pkgAlias;

  # Tools (e.g. Flutter) look for a binary literally named `chromium`.
  chromium = pkgAlias "chromium" "${pkgs.ungoogled-chromium}/bin/ungoogled-chromium";
in
{
  environment.systemPackages = with pkgs;
  [
    ungoogled-chromium # Chrome without the spyware.
    chromium
  ];

  environment.variables.CHROME_EXECUTABLE = "${chromium}/bin/chromium";
}
