# fzf
# CLI fuzzy finder.
{
  pkgs,
  ...
}:
{
  programs.fzf =
  {
    enable = true;
    enableBashIntegration = true;
  };
}
