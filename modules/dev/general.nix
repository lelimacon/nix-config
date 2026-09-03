{
  pkgs,
  pkgs-unstable,
  pkgs-wrappers,
  ...
}:
{
  environment.systemPackages = with pkgs;
  [
    # CLI tools.
    #busybox # replaced with toybox.
    toybox # ~BusyBox lightweight alternative.
    wget # not in ToyBox in nix-darwin.
    curl jq
    vim
    #kitty # terminal emulator.
    #bash # shell.
    #starship # prompt engine.
    eza # ls alternative.
    fontconfig # list fonts with `fc-list`.
    openssl # SSL & TLS library.
    cocogitto # cli tools for conventional commit and semver.
    pkgs-ext.develop
    pkgs-ext.dirt
    pkgs-ext.what
    pkgs-ext.where

    # TUI file explorers.
    ranger
    nnn

    # TUI editors.
    helix
    pkgs-unstable.fresh-editor

    # GUI editors.
    pkgs-wrappers.vscodium
    lapce

    # Build tools.
    go-task # taskfile runner.
    deno # JS/TS runtime.
  ];
}
