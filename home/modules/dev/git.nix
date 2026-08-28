{
  pkgs,
  pkgs-wrappers,
  ...
}:
{
  home.packages =
  [
    pkgs.lazygit # TUI for git commands.
    pkgs.git-lfs
    pkgs-wrappers.git
  ];
}
