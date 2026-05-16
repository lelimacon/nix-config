# SketchyBar configuration.
# https://github.com/FelixKratz/SketchyBar
#
# MacOS status bar.
# Logs in ~/Library/Logs/sketchybar
{
  pkgs,
  ...
}:
{
  programs.sketchybar =
  {
    #enable = true;
    #service.enable = true;

    configType = "lua";

    sbarLuaPackage = pkgs.sbarlua;

    extraPackages = with pkgs;
    [
      blueutil
      coreutils
      curl
      gh
      gh-notify
      gnugrep
      gnused
      jankyborders
      jq
      wttrbar
    ];

    config =
    {
      source = ./config;
      recursive = true;
    };
  };

  #home.packages = with pkgs;
  #[
  #  lua
  #];

  #home.file.".config/sketchybar/" =
  #{
  #  source = ./config;
  #  recursive = true;
  #};
}
