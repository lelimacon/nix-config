{
  pkgs,
  pkgs-unstable,
  ...
}:
{
  home.packages = with pkgs;
  [
    # CLI tools.
    #busybox # replaced with toybox.
    toybox # ~BusyBox lightweight alternative.
    wget # not in ToyBox in nix-darwin.
    curl jq
    vim
    #git git-lfs
    #git-xet # Git LFS plugin for Xet protocol.
    #kitty # terminal emulator.
    #bash # shell.
    #starship # prompt engine.
    eza # ls alternative.
    fontconfig # list fonts with `fc-list`.
    openssl # SSL & TLS library.
    cocogitto # cli tools for conventional commit and semver.

    # TUI file explorers.
    ranger
    nnn

    # TUI editors.
    helix
    pkgs-unstable.fresh-editor

    # Build tools.
    go-task # taskfile runner.
    deno # JS/TS runtime.
  ];
}
