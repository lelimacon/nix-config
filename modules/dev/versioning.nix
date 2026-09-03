{
  pkgs,
  pkgs-ext,
  pkgs-wrappers,
  ...
}:
{
  environment.systemPackages = with pkgs;
  [
    pkgs-wrappers.git
    git-lfs
    git-xet # Git LFS plugin for Xet protocol.

    lazygit # TUI for git commands.
    github-cli

    pkgs-ext.shelve # stash with less steps.
  ];
}
