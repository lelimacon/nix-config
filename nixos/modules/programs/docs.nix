{
  pkgs,
  pkgs-unstable,
  ...
}:
{
  environment.systemPackages = with pkgs;
  [
    typst typst-lsp tinymist # typesetting system.
  ];
}
