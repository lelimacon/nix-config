{
  pkgs-wrappers,
  ...
}:
{
  environment.systemPackages =
  [
    # IDE.
    pkgs-wrappers.jetbrains-rust-rover
  ];
}
