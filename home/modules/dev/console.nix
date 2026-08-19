# Console-related packages.
{
  pkgs-wrappers,
  ...
}:
{
  home.packages =
  [
    #pkgs-wrappers.nushell # installed globally in `system/modules/shells.nix`.
  ];

  # Carapace completion library — binary must be in PATH for Nushell completions.
  programs.carapace.enable = true;

  programs.starship =
  {
    enable = true;
    enableBashIntegration = true;
    #enableNushellIntegration = true; # not working here, added in Nushell configuration.
    package = pkgs-wrappers.starship;
  };
}
