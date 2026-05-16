{
  pkgs,
  ...
}:
{
  home.packages = with pkgs;
  [
    lazygit # TUI for git commands.
  ];

  programs.git =
  {
    enable = true;
    lfs.enable = true;

    settings =
    {
      core =
      {
        autocrlf = "input"; # checkout as-is, commit Unix-style.
        eol = "lf";
      };

      user.name = "lelimacon";
      user.email = "lelimacon@users.noreply.github.com";

      init.defaultBranch = "main";

      pull.rebase = true;

      mergetool.prompt = true;
    };
  };
}
