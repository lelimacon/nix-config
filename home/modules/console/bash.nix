{
  pkgs,
  ...
}:
let
  loadFileIfExists = path: "[ -f ${path} ] && . ${path}";
in
{
  programs.bash =
  {
    enable = true;

    # Bash-specific aliases.
    # Generic aliases in ./shell.nix.
    shellAliases =
    {
    };

    historyControl = [ "erasedups" ]; # erase previous duplicate entries.
    historyFileSize = 20000;

    initExtra =
    ''
      SHELL=${pkgs.bash}
      STORE_ROOT=${toString ../../..}

      # Load private bashrc if found.
      ${loadFileIfExists "$HOME/.private.bashrc"}
    '';
  };
}
