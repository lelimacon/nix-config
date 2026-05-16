# Graphviz
# Graph visualization tools.
# Provides DOT program.
{
  pkgs,
  ...
}:
{
  home.packages = with pkgs;
  [
    graphviz
  ];
}
