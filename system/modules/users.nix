{
  lib,
  pkgs,
  config,
  ...
}:
{
  # Darwin only.
  #system.primaryUser = lib.mkIf pkgs.stdenv.isDarwin config.user.name;
  #system = lib.mkIf pkgs.stdenv.isDarwin {
  #  primaryUser = config.user.name;
  #};

  # User account.
  # Set password with ‘passwd’.
  users.users.${config.user.name} =
  {
    name = config.user.name;
    description = config.user.name;
    home = config.user.homeDirectory;
  } // lib.optionalAttrs pkgs.stdenv.isLinux
  {
    isNormalUser = true;
    extraGroups =
    [
      "networkmanager"
      "wheel"
      "docker"
      "input" # for keyboard state access.
    ];
  };
}
