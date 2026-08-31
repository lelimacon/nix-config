{
  config,
  pkgs,
  pkgs-unstable,
  wrappers,
  ...
}:
let
  jdk = pkgs.javaPackages.compiler.openjdk21;
in
import ./lib.nix
{
  inherit pkgs wrappers;

  package = pkgs-unstable.jetbrains.idea;

  env =
  {
    JAVA_HOME = "${jdk}";
  };

  runtimePkgs = with pkgs;
  [
    jdk
    kotlin
    maven
    gradle_9
    git
  ];

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
