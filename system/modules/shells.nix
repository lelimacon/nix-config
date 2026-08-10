{
  pkgs,
  pkgs-local,
  config,
  ...
}:
{
  # Install wrapped nushell system-wide so /run/current-system/sw/bin/nu exists.
  environment.systemPackages =
  [
    pkgs-local.nushell
  ];

  users.users.${config.user.name}.shell = pkgs-local.nushell;

  # Add to available shells in `/etc/shells`.
  # https://discourse.nixos.org/t/how-to-set-desired-shell-with-nix-darwin/49826
  #
  # Set the default shell :
  # > chsh -s /etc/profiles/per-user/$USER/bin/bash
  # > chsh -s /run/current-system/sw/bin/bash
  # > chsh -s /run/current-system/sw/bin/nu
  environment.shells =
  [
    pkgs-local.nushell
    pkgs.nushell
    #pkgs.bash # system bash.
    #pkgs.bashInteractive
    #"/etc/profiles/per-user/${config.user.name}/bin/bash" # user bash.
  ];
}
