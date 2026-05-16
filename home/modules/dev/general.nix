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
    neofetch
    #git git-lfs
    #kitty # terminal emulator.
    #bash # shell.
    #starship # prompt engine.
    eza # ls alternative.
    fontconfig # list fonts with `fc-list`.
    openssl # SSL & TLS library.

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
