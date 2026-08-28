{
  pkgs,
  pkgs-wrappers,
  config,
  ...
}:
{
  # Install wrapped nushell system-wide so /run/current-system/sw/bin/nu exists.
  environment.systemPackages =
  [
    pkgs-wrappers.nushell # shell.
    pkgs-wrappers.starship # shell prompt.
    pkgs.carapace # completion library.
  ];

  users.users.${config.user.name}.shell = pkgs-wrappers.nushell;

  # Add to available shells in `/etc/shells`.
  # https://discourse.nixos.org/t/how-to-set-desired-shell-with-nix-darwin/49826
  #
  # Set the default shell :
  # > chsh -s /etc/profiles/per-user/$USER/bin/bash
  # > chsh -s /run/current-system/sw/bin/bash
  # > chsh -s /run/current-system/sw/bin/nu
  environment.shells =
  [
    pkgs-wrappers.nushell
    pkgs.nushell
    #pkgs.bash # system bash.
    #pkgs.bashInteractive
    #"/etc/profiles/per-user/${config.user.name}/bin/bash" # user bash.
  ];

  environment.shellAliases =
  {
    ".." = "cd ..";
    "..." = "cd ../..";

    "l" = "eza";
    "ll" = "eza -l --icons";
    "tree" = "eza --tree";

    # Git log formatting: https://gist.github.com/niun/ca61a37791ff1fdc9b33
    "gl" = "git log --graph --pretty=format:'%Cgreen%ad%Creset %C(auto)%h %s %C(bold black)<%aN>%C(auto)%d%Creset' --date=format-local:'%Y-%m-%d %H:%M'";

    # Dev shells.
    "dev" = "develop ${toString ../..}";
    "dev-builder" = "nix develop path:${toString ../../shells/gtk}    --command gnome-builder";
    "dev-rider"   = "nix develop path:${toString ../../shells/dotnet} --command rider";
    "dev-rover"   = "nix develop path:${toString ../../shells/rust}   --command rust-rover";
    "dev-unity"   = "nix develop path:${toString ../../shells/dotnet} --command unityhub";

    # Scripts.
    "nix-dirt" = "dirt --dir ~/.config --verbosity files";
  };

  environment.variables =
  {
    STORE_ROOT = toString ../..;
  };

  environment.extraInit =
  ''
    # Some (manual) installs are in unconventional locations.
    export PATH="$HOME/.local/bin:$PATH"
  '';
}
