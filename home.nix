{ config, pkgs, ... }:

let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-24.05.tar.gz";
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];

  home-manager.users.lelimacon = {
    home.stateVersion = "18.09";

    imports = [
      ./home/hyprland.nix
      ./home/terminal.nix
      ./home/ags.nix
    ];

    home.file.".gitconfig".text = ''
        [safe]
          directory = /etc/nixos
        [user]
          email = lelimacon@users.noreply.github.com
          name = lelimacon
        [pull]
          rebase = true
        [filter "lfs"]
          required = true
          clean = git-lfs clean -- %f
          smudge = git-lfs smudge -- %f
          process = git-lfs filter-process
    '';
  };
}
