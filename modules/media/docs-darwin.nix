{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs;
  [
    typst tinymist # typesetting system.
    poppler-utils # PDF utils e.g. `pdfinfo`.
  ];
}
