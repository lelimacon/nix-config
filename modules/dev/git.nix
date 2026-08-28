{
  pkgs,
  pkgs-wrappers,
  ...
}:
{
  environment.systemPackages =
  [
    pkgs.lazygit # TUI for git commands.
    pkgs.git-lfs
    pkgs-wrappers.git
  ];
}
