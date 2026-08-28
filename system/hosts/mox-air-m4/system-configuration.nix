{
  ...
}:
{
  imports =
  [
    ../../modules/fonts.nix
    ../../modules/mac-hardware.nix
    ../../modules/mac-software.nix
    ../../modules/mac-ui.nix
    ../../modules/console.nix
    ../../modules/system-defaults.nix
    ../../modules/users.nix
  ];

  # https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.stateVersion
  system.stateVersion = 6;

  #nix.extraOptions = ''
  #  auto-optimise-store = true
  #  extra-platforms = x86_64-darwin aarch64-darwin
  #'';
}
