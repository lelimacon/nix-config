{
  config,
  pkgs,
  pkgs-unstable,
  wrappers,
  ...
}:
let
  # https://github.com/bevyengine/bevy/blob/main/docs/linux_dependencies.md
  # Only the windowing/audio backends are Linux-specific; macOS uses its own.
  bevyLinuxBuildInputs = with pkgs;
  lib.optionals stdenv.isLinux
  [
    libudev-zero
    alsa-lib
    udev
    libx11 libxrandr libxcursor libxi # for X11.
    wayland # for Wayland.
  ];
in
import ./lib.nix
{
  inherit pkgs wrappers;

  package = pkgs-unstable.jetbrains.rust-rover;

  runtimePkgs = with pkgs;
  [
    openssl
    pkg-config
    libxkbcommon
    vulkan-loader
  ]
  ++ bevyLinuxBuildInputs;

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
