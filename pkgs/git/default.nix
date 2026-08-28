{
  pkgs,
  wrappers,
  ...
}:
wrappers.wrappers.git.wrap
{
  inherit pkgs;

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

    # Equivalent to what `git lfs install` / home-manager's `programs.git.lfs.enable` set up.
    filter.lfs =
    {
      clean = "${pkgs.git-lfs}/bin/git-lfs clean -- %f";
      smudge = "${pkgs.git-lfs}/bin/git-lfs smudge -- %f";
      process = "${pkgs.git-lfs}/bin/git-lfs filter-process";
      required = true;
    };
  };
}
