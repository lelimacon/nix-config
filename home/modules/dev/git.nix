{
  inputs,
  pkgs,
  ...
}:
{
  programs.git =
  {
    enable = true;
    lfs.enable = true;

    settings =
    {
      user.name = "lelimacon";
      user.email = "lelimacon@users.noreply.github.com";

      init.defaultBranch = "main";
      pull.rebase = true;
      mergetool.prompt = true;
    };
  };
}
