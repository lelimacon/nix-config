{ config, pkgs, ... }:

{
  # Install firefox.
  programs.firefox.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [

    # CLI tools.
    vim
    wget
    git
    gawk # GNU awk.

    # Utils.
    _1password-gui

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
    zulu8 # Java OpenJDK
    dotnetCorePackages.sdk_8_0_2xx
    nodejs_22
    mono # for wine (vinegar).

    # Games.
    xmoto
    vinegar # Roblox.
  ];
}
