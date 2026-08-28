{
  inputs,
  ...
}:
{
  imports =
  [
    #inputs.nixos-hardware.nixosModules.microsoft-surface-common

    ./hardware-configuration.nix

    ../../modules/hardware/audio.nix
    ../../modules/hardware/bluetooth.nix
    ../../modules/hardware/drives.nix
    ../../modules/hardware/laptop.nix
    ../../modules/hardware/logind.nix
    #../../modules/hardware/mac.nix
    ../../modules/hardware/network.nix
    ../../modules/hardware/printing.nix
    ../../modules/hardware/virtualization.nix

    ../../modules/culture.nix
    ../../modules/fonts.nix
    ../../modules/system-defaults.nix
    ../../modules/users.nix

    ../../modules/desktop/gnome.nix
    #../../modules/desktop/mac.nix
    ../../modules/desktop/wayland.nix
    ../../modules/desktop/xdg.nix

    #../../modules/dev/ai.nix
    #../../modules/dev/aws.nix
    #../../modules/dev/beam.nix
    ../../modules/dev/console.nix
    ../../modules/dev/containerization.nix
    #../../modules/dev/db.nix
    ../../modules/dev/dotnet.nix
    #../../modules/dev/gamedev.nix
    ../../modules/dev/general.nix
    ../../modules/dev/git.nix
    #../../modules/dev/go.nix
    ../../modules/dev/gtk.nix
    #../../modules/dev/java.nix
    ../../modules/dev/nix.nix
    #../../modules/dev/rust.nix
    ../../modules/dev/web.nix

    ../../modules/media/docs.nix
    #../../modules/media/emulation.nix
    ../../modules/media/flatpak.nix
    ../../modules/media/games.nix
    ../../modules/media/gfx.nix
    ../../modules/media/music.nix
    ../../modules/media/sfx.nix
    ../../modules/media/steam.nix
    ../../modules/media/torrent.nix
    ../../modules/media/video.nix

    ../../modules/social/chrome.nix
    ../../modules/social/firefox.nix
    ../../modules/social/play.nix
    ../../modules/social/slack.nix
    ../../modules/social/teams.nix

    ../../modules/utils/ext.nix
    ../../modules/utils/graphviz.nix
    ../../modules/utils/locate.nix
    #../../modules/utils/monitoring.nix
    ../../modules/utils/nix-tools.nix
    ../../modules/utils/password-manager.nix
  ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.05";
}
