{
  pkgs,
  lib,
  ...
}:
{
  environment.systemPackages = with pkgs;
  [
    typst tinymist # typesetting system.
    poppler-utils # PDF utils e.g. `pdfinfo`.
  ] ++ lib.optionals (!pkgs.stdenv.isDarwin)
  [
    gnome-clocks
  ];
}
