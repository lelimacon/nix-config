{
  pkgs,
  pkgs-stable,
  ...
}:
{
  environment.systemPackages = with pkgs;
  [
    zulu8 # Java OpenJDK.
  ];
}
