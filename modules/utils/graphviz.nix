# Graphviz
# Graph visualization tools.
# Provides DOT program.
{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs;
  [
    graphviz
  ];
}
