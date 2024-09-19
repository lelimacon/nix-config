{ config, pkgs, ... }:

{
  # Install firefox.
  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [

    # CLI tools.
    vim
    wget
    git git-lfs
    gawk
    go-task
    neofetch
    ranger nnn # CLI file explorers

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

    # Fonts.
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
    (nerdfonts.override {
      fonts = [ "FiraCode" "DroidSansMono" ];
    })

    # Games.
    xmoto
    vinegar # Roblox.
  ];
}
