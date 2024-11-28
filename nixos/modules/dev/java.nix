{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs;
  [
    zulu8 # Java OpenJDK.
  ];
}
