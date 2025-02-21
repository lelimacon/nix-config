{
  inputs,
  pkgs,
  pkgs-unstable,
  ...
}:
{
  imports =
  [
    inputs.nix-flatpak.nixosModules.nix-flatpak
  ];

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
    _1password-gui
    pavucontrol # PulseAudio Volume Control.
    mission-center # activity monitor.
    #bottles # WINE prefix manager.
    rustdesk # remote desktop sharing (OSS alternative to AnyDesk).

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
    musescore
    transmission_4

    # Dev.
    docker # GUI w/ yacht (compose service).
    lazydocker # terminal UI for Docker.
    vscodium
    jetbrains.rider # dotnet IDE.
    jetbrains.rust-rover # Rust IDE.
    postman

    # Build tools.
    go-task # taskfile runner.
    deno # JS/TS runtime.
    typst typst-lsp # typesetting system.
    meson ninja

    # Games.
    xmoto
  ];

  programs.steam =
  {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  services.flatpak =
  {
    enable = true;
    packages =
    [
      # Games.
      "app.drey.Blurble" # Wordle clone.
    ];
  };

  # Locate service, updates every night (`updatedb`).
  services.locate =
  {
    enable = true;
    package = pkgs.mlocate; # alternative to GNU findutils.
    localuser = null; # mlocate runs as root.
  };
}
