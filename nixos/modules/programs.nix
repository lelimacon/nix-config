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
  # programs.gnupg.agent =
  # {
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
    ranger nnn # CLI file explorers.
    fontconfig # list fonts with `fc-list`.
    nix-index # find nixos packages.

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

    # Build tools.
    pkgs-stable.go-task # taskfile runner.
    meson ninja

    # Languges and frameworks.
    dotnetCorePackages.sdk_8_0_4xx
    mono # for wine.
    zulu8 # Java OpenJDK.
    nodejs_22 bun # JS.
    gtk3 gtk4 # for gtk4-icon-browser.
    vala dart-sass

    # Games.
    xmoto
  ];

  # Locate service, updates (`updatedb` every night).
  services.locate =
  {
    enable = true;
    package = pkgs.mlocate; # alternative to GNU findutils.
    localuser = null; # mlocate runs as root.
  };
}
