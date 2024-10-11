{
  pkgs,
  pkgs-stable,
  ...
}:
{
  programs.firefox.enable = true;

  environment.systemPackages = with pkgs;
  [
    # CLI tools.
    wget jq gawk
    vim
    neofetch
    git git-lfs
    kitty # terminal emulator.
    bash # shell.
    starship # prompt engine.
    eza # ls alternative.
    pkgs-stable.go-task # taskfile runner.
    ranger nnn # CLI file explorers.
    fontconfig # list fonts with `fc-list`.

    # Utils.
    _1password-gui
    pavucontrol # PulseAudio Volume Control.
    mission-center # activity monitor.

    # Social.
    telegram-desktop
    slack
    discord

    # Multimedia.
    vlc
    spotify
    blender
    inkscape

    # Dev.
    docker # GUI w/ yacht (compose service).
    jetbrains.rider
    vscodium
    postman
    zulu8 # Java OpenJDK.
    dotnetCorePackages.sdk_8_0_4xx
    nodejs_22 bun # JS.
    mono # for wine (vinegar).

    # Games.
    xmoto
  ];
}
