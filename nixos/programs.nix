{
  pkgs,
  pkgs-stable,
  ...
}:
{
  # Allow unfree packages.
  nixpkgs.config.allowUnfree = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  programs.firefox.enable = true;

  environment.systemPackages = with pkgs;
  [
    # CLI tools.
    home-manager
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
    gimp
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
    gtk4 # for gtk4-icon-browser.

    # Games.
    xmoto
  ];
}
