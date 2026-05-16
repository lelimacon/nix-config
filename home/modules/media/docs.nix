{
  pkgs,
  ...
}:
{
  home.packages = with pkgs;
  [
    typst tinymist # typesetting system.
    poppler-utils # PDF utils e.g. `pdfinfo`.
    gnome-clocks
  ];
}
