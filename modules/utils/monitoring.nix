{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs;
  [
    bottom # process monitor TUI.
  ] ++ lib.optionals stdenv.isDarwin
  [
    dgop # process monitor TUI.
  ];
}
