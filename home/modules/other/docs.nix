{
  pkgs,
  pkgs-unstable,
  ...
}:
{
  home.packages = with pkgs;
  [
    typst typst-lsp tinymist # typesetting system.
  ];
}
