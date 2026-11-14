{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs;
  [
    bottom # process monitor TUI.
    dgop # process monitor TUI.
  ];
}
