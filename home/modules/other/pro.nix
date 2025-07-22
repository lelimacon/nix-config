{
  pkgs,
  pkgs-unstable,
  ...
}:
{
  home.packages = with pkgs;
  [
    slack
    teams-for-linux # https://www.reddit.com/r/NixOS/comments/jcheqg/does_microsoft_teams_work_on_nixos/
  ];
}
