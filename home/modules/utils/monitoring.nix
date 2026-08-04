{
  pkgs,
  ...
}:
{
  home.packages = with pkgs;
  [
    bottom # process monitor TUI.
    dgop # process monitor TUI.
  ];
}
