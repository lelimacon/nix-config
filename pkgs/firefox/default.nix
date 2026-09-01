{
  config,
  pkgs,
  wrappers,
}:
import ./lib.nix
{
  inherit pkgs wrappers;

  package = pkgs.firefox.override
  {
    extraPolicies = import ./policies.nix;
  };

  settings = import ./settings.nix;
  customKeys = import ./customKeys.nix;
  userChrome = import ./userChrome.css.nix { };
  userContent = import ./userContent.css.nix { inherit config; };
}
