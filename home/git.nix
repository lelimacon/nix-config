{
  inputs,
  pkgs,
  ...
}:
{
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
}
