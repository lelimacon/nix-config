{
  config,
  ...
}:
{
  imports =
  [
    #../modules/console/ghostty.nix # installed via Homebrew.
    ../modules/console/shell.nix
    ../modules/customization/sketchybar

    ../modules/dev/ai.nix
    #../modules/dev/asdf.nix
    ../modules/dev/aws.nix
    ../modules/dev/beam.nix
    ../modules/dev/console.nix
    #../modules/dev/containerization.nix # Docker installed manually.
    ../modules/dev/db.nix
    ../modules/dev/general.nix
    ../modules/dev/git.nix
    ../modules/dev/go.nix
    ../modules/dev/java.nix
    #../modules/dev/jetbrains.nix
    #../modules/dev/mise.nix
    ../modules/dev/nix.nix
    ../modules/dev/web.nix

    ../modules/media/docs.nix
    #../modules/media/gfx.nix
    ../modules/media/music.nix

    #../modules/social/chrome.nix # installed via Homebrew.
    ../modules/social/firefox.nix
    ../modules/social/slack.nix

    ../modules/utils/ext.nix
    ../modules/utils/console.nix
    ../modules/utils/fzf.nix
    ../modules/utils/graphviz.nix
    ../modules/utils/monitoring.nix
    ../modules/utils/nix-tools.nix
    #../modules/utils/password-manager.nix # 1password installed manually.
  ];

  home.stateVersion = "25.11";
  home.username = config.user.name;
  home.homeDirectory = config.user.homeDirectory;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
