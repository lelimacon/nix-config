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

    home.file.".bashrc".text = ''
        alias ..='cd ..'
        alias ...='cd ../..'
        alias code='codium'
    '';

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
