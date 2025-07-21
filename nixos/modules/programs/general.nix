{
  pkgs,
  pkgs-unstable,
  ...
}:
{
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent =
  # {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  environment.systemPackages = with pkgs;
  [
    # CLI tools.
    home-manager
    busybox curl jq
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
    openssl # SSL & TLS library.

    # Utils.
    pkgs-unstable._1password-gui
    pavucontrol # PulseAudio Volume Control.
    mission-center # activity monitor.
    rustdesk # remote desktop sharing (OSS alternative to AnyDesk).

    # Wine.
    #bottles # WINE prefix manager.

    # Social.
    firefox
    ungoogled-chromium # chrome without the spyware.
    telegram-desktop
    slack
    discord
    teams-for-linux # https://www.reddit.com/r/NixOS/comments/jcheqg/does_microsoft_teams_work_on_nixos/

    # Multimedia.
    vlc
    spotify
  ];

  # Locate service, updates every night (`updatedb`).
  services.locate =
  {
    enable = true;
    package = pkgs.mlocate; # alternative to GNU findutils.
    localuser = null; # mlocate runs as root.
  };
}
