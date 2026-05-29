{
  vars,
  ...
}:
{
  imports =
  [
    ../customization.nix

    ../desktops/gnome
    #../desktops/hyprland

    ../modules/console/bash.nix
    ../modules/console/ghostty.nix
    ../modules/console/gtk.nix
    ../modules/console/kitty.nix
    ../modules/console/nushell
    ../modules/console/shell.nix
    ../modules/console/starship.nix

    ../modules/dev/dotnet.nix
    ../modules/dev/containerization.nix
    #../modules/dev/db.nix
    #../modules/dev/gamedev.nix
    ../modules/dev/general.nix
    ../modules/dev/git.nix
    ../modules/dev/gtk.nix
    #../modules/dev/java.nix
    ../modules/dev/nix.nix
    #../modules/dev/rust.nix
    ../modules/dev/vscode.nix
    ../modules/dev/web.nix

    ../modules/media/docs.nix
    #../modules/media/emulation.nix
    ../modules/media/games.nix
    ../modules/media/gfx.nix
    ../modules/media/music.nix
    ../modules/media/sfx.nix
    ../modules/media/torrent.nix
    ../modules/media/video.nix

    ../modules/social/chrome.nix
    ../modules/social/firefox
    ../modules/social/play.nix
    ../modules/social/slack.nix
    ../modules/social/teams.nix

    ../modules/utils/fzf.nix
    ../modules/utils/graphviz.nix
    ../modules/utils/local-packages.nix
    ../modules/utils/nix-tools.nix
    ../modules/utils/password-manager.nix
  ];

  home.stateVersion = "24.05";
  home.username = vars.user.name;
  home.homeDirectory = vars.user.homeDirectory;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
