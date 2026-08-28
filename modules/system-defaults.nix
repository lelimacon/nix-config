{
  config,
  ...
}:
{
  # Enable flakes.
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Set Git commit hash for darwin-version.
  system.configurationRevision = config.flake-src.rev;
}
