{
  pkgs,
  ...
}:
{
  home.packages = with pkgs;
  [
    zulu8 # Java OpenJDK.
  ];
}
