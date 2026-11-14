{
  pkgs,
  pkgs-unstable,
  pkgs-wrappers,
  pkgs-ext,
  ...
}:
{
  environment.systemPackages = with pkgs;
  [
    # Applets Toybox/BusyBox used to shadow, from their canonical packages.
    # coreutils, util-linux, gnutar, gnugrep, gnused, gawk
    # and findutils already come from the NixOS defaults.
    file # `file`.
    pciutils # `lspci`.
    usbutils # `lsusb`.
    binutils # `strings`, `readelf`.

    # CLI tools.
    wget
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
    #pkgs-unstable.fresh-editor
    #fresh-editor
    (pkgs-unstable.fresh-editor.overrideAttrs (old: {
      nativeBuildInputs = (old.nativeBuildInputs or []) ++ [ pkg-config ];
      buildInputs = (old.buildInputs or []) ++ [ oniguruma ];
    }))

    # GUI editors.
    pkgs-wrappers.vscodium
    lapce

    # Build tools.
    go-task # taskfile runner.
    deno # JS/TS runtime.
  ];
}
