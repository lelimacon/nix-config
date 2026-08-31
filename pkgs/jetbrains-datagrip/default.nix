{
  config,
  pkgs,
  pkgs-unstable,
  wrappers,
  ...
}:
import ./lib.nix
{
  inherit pkgs wrappers;

  package = pkgs-unstable.jetbrains.datagrip;

  settings =
  {
    # JetBrains' font isn't ligature-aware, so it needs the "frozen" font variant.
    fonts =
    {
      fontFamily = config.theme.monoFont.frozenFamily;
      useLigatures = true;
    };

    themeId = "Islands Light";
    colorScheme = "Light";

    editor =
    {
      stripTrailingSpaces = "Whole";
      keepTrailingSpaceOnCaretLine = false;
    };
  };
}
