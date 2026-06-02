{
  inputs,
  config,
  pkgs,
  pkgs-unstable,
  pkgs-local,
  ...
}:
{
  imports =
  [
    # TODO: Remove
    inputs.home-manager.darwinModules.home-manager

    ../../modules/fonts.nix
    ../../modules/mac-hardware.nix
    ../../modules/mac-software.nix
    ../../modules/mac-ui.nix
    ../../modules/system-defaults.nix
    ../../modules/yabai.nix
  ];

  # https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.stateVersion
  system.stateVersion = 6;

  #nix.extraOptions = ''
  #  auto-optimise-store = true
  #  extra-platforms = x86_64-darwin aarch64-darwin
  #'';

  # Set the Mac user.
  # TODO: Unify with users.nix
  system.primaryUser = config.user.name;
  users.users.${config.user.name} =
  {
    name = config.user.name;
    home = "/Users/${config.user.name}";
    shell = pkgs.nushell;
  };

  # https://discourse.nixos.org/t/how-to-set-desired-shell-with-nix-darwin/49826
  # Add to available shells in /etc/shells
  # Set Bash as the default shell :
  # > chsh -s /etc/profiles/per-user/$USER/bin/bash
  # > chsh -s /run/current-system/sw/bin/bash
  # > chsh -s /run/current-system/sw/bin/nu
  # TODO: Move to common module.
  environment.shells =
  [
    pkgs.nushell
    #pkgs.bash # system bash.
    #pkgs.bashInteractive
    #"/etc/profiles/per-user/${config.user.name}/bin/bash" # user bash.
  ];

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = config.host.system;
}
