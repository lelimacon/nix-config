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
    jetbrains.rider
    vscodium
    postman

    # Games.
    xmoto
    vinegar # Roblox.
  ];
}
