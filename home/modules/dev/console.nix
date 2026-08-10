# Console packages from pkgs-local (nix-wrapper-modules).
{ pkgs-local, ... }:
{
  programs.starship =
  {
    enable = true;
    enableBashIntegration = true;
    #enableNushellIntegration = true; # integration.
    package = pkgs-local.starship;
  };
}
