{
  config,
  pkgs,
  pkgs-unstable,
  wrappers,
  ...
}:
let
  erlang = pkgs.beam27Packages.erlang;
  elixir = pkgs.beam27Packages.elixir_1_19;
in
import ./lib.nix
{
  inherit pkgs wrappers;

  package = pkgs-unstable.jetbrains.webstorm;

  env =
  {
    ERL_TOP = "${erlang}/lib/erlang";
    ERLANG_SDK_HOME = "${erlang}/lib/erlang";
    ELIXIR_SDK_HOME = "${elixir}/lib/elixir";
    GLEAM_SDK_HOME = "${elixir}/lib/elixir";
  };

  runtimePkgs = with pkgs;
  [
    # Node.
    nodejs_22

    # Beam.
    erlang
    elixir
    gleam

    # Utilities.
    caddy
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
