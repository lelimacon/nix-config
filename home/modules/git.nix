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

    userName = "lelimacon";
    userEmail = "lelimacon@users.noreply.github.com";
  
    extraConfig =
    {
      init.defaultBranch = "main";
      pull.rebase = true;
      mergetool.prompt = true;

      # To avoid "fatal: detected dubious ownership in repository" when su.
      safe.directory = "/x/*";
    };
  };
}
